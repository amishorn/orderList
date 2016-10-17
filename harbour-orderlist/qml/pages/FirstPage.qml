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

        move: Transition {
            NumberAnimation { properties: "x,y"; duration: 500 }
        }

        VerticalScrollDecorator {}

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {

            MenuItem { // view Settings page
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }

            MenuItem { // Save current list to xml document
                text: qsTr("Save")
                onClicked: olModel.exportList();
            }

            MenuItem { // Add an item to the list
                text: qsTr("Add Item")
                onClicked: {
                    var dialAddItem = pageStack.push(Qt.resolvedUrl("AddItem.qml"))
                    dialAddItem.sections = olModel.getSections()
                    dialAddItem.entities = olModel.getEntities()
                    dialAddItem.accepted.connect(function() {
                        olModel.addNewItem(listView.checkFolding(dialAddItem.dialAccSec), dialAddItem.dialAccSec, dialAddItem.dialAccName,
                                           dialAddItem.dialAccEntity, "1", dialAddItem.dialAccNote)})
                }
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
                        }
                    }
                }
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
            width: parent.width
            menu: lItemCM

            ListView.onAdd: AddAnimation {
                target: listItem
            }

            ListView.onRemove: RemoveAnimation {
                target: listItem
            }

            visible: !folded
            height: (folded) ? 0 : Theme.itemSizeSmall + lItemCM.height

            Row {
                id: litemRow

                Switch {
                    id: listSwitch
                    parent: litemRow
                    height: labelItem.height
                    anchors.top: parent.top
                    checked: selected
                    onClicked: selected = checked
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
                MenuItem {
                    text: qsTr("Move Up")
                    onClicked: olModel.moveItemUp(index)
                    enabled: (index > 0)
                }
                MenuItem {
                    text: qsTr("Remove")
                    onClicked: olModel.removeItem(index)
                }
                MenuItem {
                    text: qsTr("Edit")
                    onClicked: {
                        var dialAddItem = pageStack.push(Qt.resolvedUrl("AddItem.qml"))
                        dialAddItem.dialAccSec = section
                        dialAddItem.dialAccName = name
                        dialAddItem.dialAccEntity = entity
                        dialAddItem.dialAccNote = note
                        dialAddItem.sections = olModel.getSections()
                        dialAddItem.entities = olModel.getEntities()
                        dialAddItem.accepted.connect(function() {
                            olModel.replaceItem(index, listView.checkFolding(dialAddItem.dialAccSec), dialAddItem.dialAccSec, dialAddItem.dialAccName,
                                                dialAddItem.dialAccEntity, "1", dialAddItem.dialAccNote)})
                    }
                }

                MenuItem {
                    text: qsTr("Move Down")
                    onClicked: olModel.moveItemDown(index)
                    enabled: (index+1 < olModel.count)
                }

            }
            onClicked: {
                quantSlider.value = quantity
                quantSelPanel.open = true
                quantSelPanel.curItem = index
            }
        }

        DockedPanel {
            id: quantSelPanel

            dock: Dock.Bottom
            width: parent.width
            height: quantSlider.height

            property int curItem: 0

            Slider {
                id: quantSlider

                width: parent.width - dPAccButton.width
                minimumValue: 1
                maximumValue: 15
                stepSize: 1
                valueText: value
            }

            IconButton {
                id: dPAccButton

                anchors.left: quantSlider.right
                icon.source: "image://theme/icon-m-enter-accept"

                onClicked: {
                    olModel.setQuantity(quantSelPanel.curItem, quantSlider.value.toString())
                    quantSelPanel.open = false
                }
            }
        }
    }
}



