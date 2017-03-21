import QtQuick 2.5

Rectangle {
    id: tocImpl
    width: 250
    height: sharesCountText.height + spacer1.height + tableItem.height

    property var tableOfContentModel
    property int itemHeight: 40

    Column {
        anchors.fill: parent

        Image {
            id: sharesCountText
            width: 108
            height: 26
            anchors.right: parent.right
            source: "../imgs/toc.png"
        }

        Item {
            id: spacer1
            width: parent.width
            height: 20
        }

        Item {
            id: tableItem
            width: parent.width
            height: tocImpl.itemHeight * tocRepeater.count

            Column {
                id: layout
                anchors.fill: parent

                Repeater {
                    id: tocRepeater
                    model: tableOfContentModel
                    delegate: Item {
                        width: tocImpl.width
                        height: tocImpl.itemHeight

                        Text {
                            anchors.top: parent.top
                            anchors.right: parent.right
                            font.pixelSize: 18
                            color: "#6a6a6a"
                            text: title
                        }
                    }
                }
            }
        }
    }
}
