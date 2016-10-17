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
                label: qsTr("Text before order list")
                placeholderText: qsTr("pre-list text")
                text: cfgPreLTxt.value
                onTextChanged: cfgPreLTxt.value = preLTxtTA.text
            }

            TextArea {
                id: postLTxtTA
                width: parent.width
                label: qsTr("Text after order list")
                placeholderText: qsTr("post-list text")
                text: cfgPostLTxt.value
                onTextChanged: cfgPostLTxt.value = postLTxtTA.text
            }
        }
    }
}
