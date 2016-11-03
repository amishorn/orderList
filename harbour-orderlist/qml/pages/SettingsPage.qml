import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: setPage

    SilicaFlickable {
        id: setPageView
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge

        VerticalScrollDecorator {}

        Column {
            id: column
            width: parent.width

            PageHeader {
                id: setPageHead
                title: qsTr("Settings")
            }

            SectionHeader {
                id: emailSetSH
                text: qsTr("e-mail settings")
            }

            TextField {
                id: mAddrTF
                width: parent.width
                label: qsTr("e-mail address")
                placeholderText: qsTr("e-mail")
                text: cfgMailAddr.value
                onTextChanged: cfgMailAddr.value = mAddrTF.text
            }

            TextArea {
                id: preLTxtTA
                width: parent.width
                font.italic: true
                font.pointSize: 6
                label: qsTr("Text before order list")
                placeholderText: qsTr("pre-list text")
                text: cfgPreLTxt.value
                onTextChanged: cfgPreLTxt.value = preLTxtTA.text
            }

            TextArea {
                id: postLTxtTA
                width: parent.width
                font.italic: true
                font.pointSize: 6
                label: qsTr("Text after order list")
                placeholderText: qsTr("post-list text")
                text: cfgPostLTxt.value
                onTextChanged: cfgPostLTxt.value = postLTxtTA.text
            }

            SectionHeader {
                id: saveSetSH
                text: qsTr("Save settings")
            }

            TextSwitch {
                id: saveEntriesTS
                width: parent.width
                text: qsTr("save list when modified")
                checked: cfgSaveEntries.value
                onClicked: cfgSaveEntries.value = checked
            }

            TextSwitch {
                id: saveSelectionsTS
                width: parent.width
                text: qsTr("save selections")
                checked: cfgSaveSelection.value
                onClicked: cfgSaveSelection.value = checked
            }

            SectionHeader {
                id: appearSH
                text: qsTr("Appearance")
            }

            TextSwitch {
                id: enPUMenuTS
                width: parent.width
                text: qsTr("enable push-up menu")
                checked: cfgEnPushUpMenu.value
                onClicked: cfgEnPushUpMenu.value = checked
            }
        }
    }
}
