import QtQuick 2.2
import Sailfish.Silica 1.0

Page {
    id: aboutPage

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: apColumn.height + Theme.paddingLarge

        VerticalScrollDecorator {}

        Column {
            id: apColumn
            width: parent.width

            PageHeader {
                id: apPHeader

                title: qsTr("OrderList v.%1").arg(APP_VERSION)
            }

            SectionHeader {
                id: apHeaderNotes
                text: qsTr("App Notes")
            }

            Label {
                id: apInfoLabel
                anchors {
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                    right: parent.right
                    rightMargin: Theme.paddingLarge
                }

                wrapMode: Text.WordWrap
                font.pixelSize: Theme.fontSizeSmall

                text: qsTr( "This app allows you to easily place an order by mail for items that you quite frequently use.\
In behind, there is an .xml database where all listed items are stored and that is (depending on your settings)\
updated when the list is changed. By means of the 'Add Item' dialog items can be appended to the list, whereby,\
they are always appended to a section. The sections can be moved up and down over the context menu. Entries\
however, can be moved per drag and drop where they are dragged by means of a press and hold down on an item\
until the context menu disappears.
As soon as you have added at least one item to the list, it also be maintained by means of a common text editor. The backend order list file custOrderList.xml is stored in the folder:
.local/share/harbour-orderlist/harbour-orderlist/" )
            }

            SectionHeader {
                id: apHeaderLinks
                text: qsTr("Links")
            }

            Label {
                id: apContLabel
                anchors {
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                    right: parent.right
                    rightMargin: Theme.paddingLarge
                }

                wrapMode: Text.WordWrap
                font.pixelSize: Theme.fontSizeSmall

                text: qsTr("For suggestions or any questions, please don't hesitate to contact me:")
            }

            Label {
                id: apMailAddr
                anchors {
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                    right: parent.right
                    rightMargin: Theme.paddingLarge
                }
                font.italic: true

                property string urlstring: "hiroshima@bluewin.ch"
                text: "<a href=\"" + urlstring + "\">" +  urlstring + "<\a>"
                onLinkActivated: Qt.openUrlExternally("mailto:" + link + "?subject=[OrderList]")
            }

            SectionHeader {
                id: apHeaderDons
                text: qsTr("Donations")
            }

            Label {
                id: apDonations
                anchors {
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                    right: parent.right
                    rightMargin: Theme.paddingLarge
                }
                font.italic: true
                truncationMode: TruncationMode.Fade

                property string urlstring: "https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=hiroshima%40bluewin%2ech&lc=US&item_name=hiroshima&item_number=12201600001&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donate_LG%2egif%3aNonHosted"
                text: "<a href=\"" + urlstring + "\">" + urlstring + "<\a>"
                onLinkActivated: Qt.openUrlExternally(link)
            }
        }
    }
}
