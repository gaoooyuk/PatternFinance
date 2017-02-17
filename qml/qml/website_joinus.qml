import QtQuick 2.5

Rectangle {
    id: mainWindow

    property string coverImage: "../imgs/joinus/cover.png"

    function qmlWidth(w) {
        return w + 1
    }

    function qmlHeight(h) {
        return h + 1
    }

    height: coverPanel.height
//            + articlePanel.height

    ListModel {
        id: contentModel
    }

    Column {
        anchors.fill: parent

        Rectangle {
            id: coverPanel
            width: parent.width
            height: width * 0.48

            Image {
                anchors.fill: parent
                source: coverImage
            }
        }

//        Rectangle {
//            id: articlePanel
//            width: parent.width
//            height: articleContentPanel.height

//            Rectangle {
//                id: contentPanel
//                width: {
//                    if (articlePanel.width >= 700) {
//                        return 700
//                    }

//                    return articlePanel.width * 0.85
//                }
//                height: parent.height
//                anchors.horizontalCenter: parent.horizontalCenter

//                Column {
//                    anchors.fill: parent

//                    Item {
//                        id: articleContentPanel
//                        width: parent.width
//                        height: {
//                            var h = 0
//                            for (var i = 1; i < contentLayout.children.length; i++) {
//                                h += contentLayout.children[i].height
//                            }

//                            h += contentLayout.spacing * contentLayout.children.length

//                            return h
//                        }

//                        Column {
//                            id: contentLayout
//                            anchors.fill: parent
//                            spacing: 40

//                            Repeater {
//                                model: contentModel
//                                delegate: Item {
//                                    width: contentPanel.width
//                                    height: {
//                                        var h = 0
//                                        if ("img" === type) {
//                                            h = imgItem.height
//                                        } else if ("txt" === type) {
//                                            h = textItem.height
//                                        } else if ("sectionHeader" === type) {
//                                            h = textItem.height + 50
//                                        }

//                                        return h
//                                    }

//                                    Image {
//                                        id: imgItem
//                                        width: qmlWidth(contentPanel.width)
//                                        height: width * ratio
//                                        anchors.centerIn: parent
//                                        source: "img" === type ? content : ""
//                                        visible: "img" === type
//                                    }

//                                    Text {
//                                        id: textItem
//                                        width: qmlWidth(contentPanel.width)
//                                        anchors.bottom: parent.bottom
//                                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
//                                        lineHeight: 30
//                                        font.pixelSize: "sectionHeader" === type ? 30 : 18
//                                        font.bold: "sectionHeader" === type ? true : false
//                                        color: "sectionHeader" === type ? "#2a2a2a" : "#4a4a4a"
//                                        text: content
//                                        visible: "txt" === type || "sectionHeader" === type
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
    }
}
