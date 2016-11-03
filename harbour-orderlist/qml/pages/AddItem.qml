import QtQuick 2.2
import Sailfish.Silica 1.0

Dialog {
    id: dialAddItem

    property string defSelVal: qsTr("Select")
    property string dialAccSec: ""
    property string dialAccName: ""
    property string dialAccEntity: ""
    property string dialAccNote: ""
    property var sections: []
    property var entities: []

    canAccept: (dialAccEntity) && (dialAccSec) && (tfItem.text)


    SilicaFlickable {
        // ComboBox requires a flickable ancestor
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge

        VerticalScrollDecorator {}

        Column {
            id: column
            width: parent.width

            DialogHeader {
                id: addItemHeader
                title: qsTr("Add Item")
            }

            TextSwitch {
                id: entSwitch
                text: qsTr("New Entity")
            }

            ComboBox {
                id: entCombo

                visible: !entSwitch.checked
                width: parent.width
                label: qsTr("Entity:")
                value: (dialAccEntity !== "") ? dialAccEntity : defSelVal
                currentIndex: -1

                menu: ContextMenu {
                    id: entComboCM

                    Repeater {
                        model: entities
                        delegate: MenuItem {
                            text: entities[index]
                        }
                    }
                }

                onCurrentIndexChanged: dialAccEntity = value = entities[currentIndex]
            }

            TextField {
                id: entTF

                visible: entSwitch.checked
                width: parent.width
                placeholderText: qsTr("New Entity")

                onTextChanged: dialAccEntity = entTF.text
            }

            TextSwitch {
                id: secSwitch
                text: qsTr("New Section")
            }

            ComboBox {
                id: secCombo

                visible: !secSwitch.checked
                width: parent.width
                label: qsTr("Section:")
                value: (dialAccSec !== "") ? dialAccSec : defSelVal
                currentIndex: -1

                menu: ContextMenu {
                    id: secComboCM

                    Repeater {
                        id: rep
                        model: sections
                        delegate: MenuItem {
                            text: sections[index].toString()
                        }
                    }
                }

                onCurrentIndexChanged: dialAccSec = value = sections[currentIndex]
            }

            TextField {
                id: secTF

                visible: secSwitch.checked
                width: parent.width
                placeholderText: qsTr("New Section")

                onTextChanged: dialAccSec = secTF.text
            }

            TextField {
                id: tfItem

                width: parent.width
                placeholderText: qsTr("New Item")
                text: (dialAccName !== "") ? dialAccName : ""

                onTextChanged: dialAccName = tfItem.text
            }

            TextField {
                id: tfNote

                width: parent.width
                placeholderText: qsTr("Note")
                text: (dialAccNote !== "") ? dialAccNote : ""

                onTextChanged: dialAccNote = tfNote.text
            }
        }
    }
}

