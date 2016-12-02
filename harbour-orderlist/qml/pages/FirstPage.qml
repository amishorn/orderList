/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.orderlist.OLModel 1.0

Page {
    id: firstPage

    SilicaListView {

        id: listView
        anchors.fill: parent
        focus: true

//        move: Transition {
//            id: vTransition
//            NumberAnimation { properties: "y"; duration: 500 }
//        }

        VerticalScrollDecorator {}

        MouseArea {
            id: flMArea

            anchors.fill: parent
            enabled: false

            onClicked: {
                olModel.setQuantity(quantSelPanel.curItem, quantSelPanel.quantity)
                quantSelPanel.hide()
            }
        }

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            id: flPDMenu

            MenuItem { // view Settings page
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }

            MenuItem { // Save current list to xml document
                visible: !cfgSaveEntries.value
                enabled: !cfgSaveEntries.value
                text: qsTr("Save")
                onClicked: olModel.exportList()
            }

            MenuItem {
                visible: cfgSaveSelection.value
                enabled: cfgSaveSelection.value
                text: qsTr("Clear Selection")
                onClicked: olModel.clearSelection()
            }

            MenuItem { // Add an item to the list
                text: qsTr("Add Item")
                onClicked: listView.appendItem()
            }

            MenuItem { // Send full list to default receiver
                text: qsTr("Send")
                onClicked: {
                    Qt.openUrlExternally("mailto:" + cfgMailAddr.value +
                                         "?subject=OrderList" +
                                         "&body=" + cfgPreLTxt.value + "\n" +
                                         olModel.getOrderListTxt() + "\n" +
                                         cfgPostLTxt.value)
                }
            }
        }

        PushUpMenu {
            id: flPUMenu
            enabled: cfgEnPushUpMenu.value
            visible: cfgEnPushUpMenu.value

            MenuItem { // Add an item to the list
                text: qsTr("Add Item")
                onClicked: listView.appendItem()
            }

            MenuItem { // Send full list to default receiver
                text: qsTr("Send")
                onClicked: {
                    Qt.openUrlExternally("mailto:" + cfgMailAddr.value +
                                         "?subject=OrderList" +
                                         "&body=" + cfgPreLTxt.value + "\n" +
                                         olModel.getOrderListTxt() + "\n" +
                                         cfgPostLTxt.value)
                }
            }
        }

        header: PageHeader{
            id: pHeader
            title: "Order List"
        }

        model: OLModel {
            id: olModel
        }

        section {
            id: secSec
            property: "section"
            delegate: ListItem {
                id: secLI
                menu: secCM

                SectionHeader {
                    id: secSH
                    text: section
                    font.italic: listView.checkFolding(section)
                }

                onClicked: {
                    for(var i=0; i<olModel.count; i++)
                        if(olModel.getRoleOfItem(i, "section") === section)
                            olModel.setFolded(i, !olModel.getRoleOfItem(i, "folded"))

                    secSH.font.italic = !secSH.font.italic
                }

                Component {
                    id: secCM
                    ContextMenu {
                        id: secCMII
                        property int action //0-noAction, 1-MoveUp, 2-MoveDown

                        MenuItem {
                            text: qsTr("Move Up")
                            onClicked: action = 1
                        }
                        MenuItem {
                            text: qsTr("Move Down")
                            onClicked: action = 2
                        }
                        onClosed: {
                            switch(action) {
                            case 1: olModel.moveSectionUp(section); break
                            case 2: olModel.moveSectionDown(section); break
                            default: break
                            }

                            if(cfgSaveEntries.value) olModel.exportList()
                        }
                    }
                }
            }
        }

        function appendItem() {
            var dialAddItem = pageStack.push(Qt.resolvedUrl("AddItem.qml"),
                                             {
                                                 sections: olModel.getSections(),
                                                 entities: olModel.getEntities()
                                             }, PageStackAction.Immediate)

            dialAddItem.accepted.connect(function() {
                olModel.addNewItem(listView.checkFolding(dialAddItem.dialAccSec), dialAddItem.dialAccSec, dialAddItem.dialAccName,
                                   false, dialAddItem.dialAccEntity, "1", dialAddItem.dialAccNote)})
            if(cfgSaveEntries.value) {
                dialAddItem.accepted.connect(function() {
                    olModel.exportList()})
            }
        }

        function checkFolding(pSection) {
            var i=0
            while((i<olModel.count) && (pSection !== olModel.getRoleOfItem(i, "section"))) { i++ }
            if(i<olModel.count) return olModel.getRoleOfItem(i, "folded")
            else return false
        }


        delegate: ListItem {
            id: listItem
            parent: listView
            focus: true
            width: parent.width
            menu: lItemCM
            visible: !folded
            height: (folded) ? 0 : Theme.itemSizeSmall + lItemCM.height

            property int mNextIndex: -1
            property int mYPos: -1

            ListView.onAdd: listView.positionViewAtIndex(index, ListView.Visible)
            ListView.onRemove: animateRemoval(listItem)

            Timer {
                id: lITimer

                interval: 1000
                onTriggered: {
                    stop()

                    // initiate move
                    listItem.highlighted = false
                    listItem.down = true
                    lItemCM.active = false
                    drag.target = listItem
                    drag.axis = Drag.YAxis
                    drag.threshold = 2

                    // update current state
                    var curPos = mapToItem(listView.contentItem, mouseX, mouseY)
                    listItem.mYPos = curPos.y
                    listItem.mNextIndex = listView.indexAt(curPos.x, curPos.y + height)
                }
            }

            onPressed: highlighted = true

            onClicked: {
                quantSelPanel.curItem = index
                quantSelPanel.quantity = quantity
                quantSelPanel.entity = entity
                quantSelPanel.show()
                console.log("current index: " + index)
            }

            onPressAndHold: {
                lITimer.start()
            }

            onPositionChanged: {
                if(drag.target){
                    var move = "no"
                    var curPos = mapToItem(listView.contentItem, mouse.x, mouse.y)
                    var tarIndex = listView.indexAt(curPos.x, curPos.y)
                    var nextIndex = listView.indexAt(curPos.x, curPos.y + height)

                    // detect moving direction
                    if(curPos.y > mYPos) move = "down"
                    if(curPos.y < mYPos) move = "up"

                    // move items according direction and current position
                    if(move === "up")
                        if(tarIndex < index && tarIndex !== -1)
                            olModel.moveItemUp(index)
                    if(move === "down")
                        if(nextIndex !== mNextIndex)
                            olModel.moveItemDown(index)

                    mYPos = curPos.y
                    mNextIndex = nextIndex

                    if(cfgSaveEntries.value) olModel.exportList()
                }
            }

            onCanceled: { console.log("mouse canceled - current item: " + index)
                if(drag.target) {
                    drag.target = null
                    olModel.updateEntry(index)
                }

                listItem.highlighted = false
            }

            onReleased: {
                console.log("mouse released - current item: " + index)

                if(drag.target) {
                    drag.target = null
                    olModel.updateEntry(index)
                }

                if(lITimer.running)
                    lITimer.stop()

                listItem.highlighted = false
            }

            Row {
                id: litemRow

                Switch {
                    id: listSwitch
                    parent: litemRow
                    height: labelItem.height
                    anchors.top: parent.top
                    checked: selected

                    onClicked: {
                        selected = checked
                        if(cfgSaveSelection) olModel.exportList()
                    }
                }

                Column {
                    id: labelCol
                    width: listItem.width - listSwitch.width

                    Label {
                        id: labelItem
                        parent: labelCol
                        width: parent.width
                        truncationMode: TruncationMode.Fade
                        text: quantity + "\t" + entity + "\t" + name
                    }

                    Label {
                        id: labelNote
                        parent: labelCol
                        width: parent.width - 45
                        anchors.rightMargin: 45
                        anchors.right: parent.right
                        font.italic: true
                        font.pixelSize: Theme.fontSizeExtraSmall
                        truncationMode: TruncationMode.Fade
                        horizontalAlignment: Text.AlignRight

                        text: (note !== null) ? note : null
                    }
                }
            }

            ContextMenu {
                id: lItemCM

//                MenuItem {
//                    text: qsTr("Move Up")
//                    onClicked: {
//                        olModel.moveItemUp(index)
//                        if(cfgSaveEntries.value) olModel.exportList()
//                    }
//                    enabled: (index > 0)
//                }

                on_HighlightedItemChanged: lITimer.stop()

                MenuItem {
                    text: qsTr("Remove")
                    onClicked: {
                        remorseAction("Deleting", function() { olModel.removeItem(index) })
                        if(cfgSaveEntries.value) olModel.exportList()
                    }
                }

                MenuItem {
                    text: qsTr("Edit")
                    onClicked: {
                        var dialAddItem = pageStack.push(Qt.resolvedUrl("AddItem.qml"),
                                                         {
                                                             dialAccSec: section,
                                                             dialAccName: name,
                                                             dialAccEntity: entity,
                                                             dialAccNote: note,
                                                             sections: olModel.getSections(),
                                                             entities: olModel.getEntities(),
                                                         }, PageStackAction.Immediate)

                        dialAddItem.accepted.connect(function() {
                            olModel.replaceItem(index, listView.checkFolding(dialAddItem.dialAccSec), dialAddItem.dialAccSec, dialAddItem.dialAccName,
                                                selected, dialAddItem.dialAccEntity, "1", dialAddItem.dialAccNote)})
                        if(cfgSaveEntries.value) {
                            dialAddItem.accepted.connect(function() {
                                olModel.exportList()})
                        }
                    }
                }

//                MenuItem {
//                    text: qsTr("Move Down")
//                    onClicked: {
//                        olModel.moveItemDown(index)
//                        if(cfgSaveEntries.value) olModel.exportList()
//                    }
//                    enabled: (index+1 < olModel.count)
//                }
            }
        }

        DockedPanel {
            id: quantSelPanel
            height: quantSelector.height + quantLabel.height

            dock: Dock.Bottom
            width: parent.width

            property int curItem: 0
            property int quantity: 0
            property string entity: ""

            onOpenChanged: {
                flMArea.enabled = quantSelPanel.open
                if(open) {
                    quantSelector.coarse = quantity / 10
                    quantSelector.fine = quantity % 10
                    console.log(quantity)
                }
            }

            Column {
                id: quantColumn
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    id: quantLabel
                    width: parent.width
                    font.pixelSize: Theme.fontSizeHuge
                    horizontalAlignment: Text.AlignHCenter
                    text: quantSelPanel.quantity + " " + quantSelPanel.entity
                }

                QuantSelector {
                    id: quantSelector
                    height: Screen.width *4 / 5
                    width: Screen.width *4 / 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    onCoarseChanged: quantSelPanel.quantity += quantSelector.cdelta *10
                    onFineChanged: quantSelPanel.quantity += quantSelector.fdelta
                }
            }
        }
    }
}



