import QtQuick 2.5

Rectangle {
    id: mainWindow

    property string coverImage: "../imgs/about/cover.png"
    property int lastHeightOnDisplay: 0

    function qmlWidth(w) {
        return w + 1
    }

    function qmlHeight(h) {
        return h + 1
    }

    height: snsBar.height
            + coverPanel.height
            + articlePanel.height

    ListModel {
        id: contentModel
        ListElement {
            type: "img"
            ratio: 0.5
            content: "https://img.evbuc.com/https%3A%2F%2Fcdn.evbuc.com%2Fimages%2F27734528%2F126528235865%2F1%2Foriginal.jpg?w=800&rect=7%2C0%2C3192%2C1596&s=896609348a297fc556a403258afdd604"
        }
        ListElement {
            type: "img"
            ratio: 0.67
            content: "http://battleofthequants.com/wp-content/uploads/2014/08/Bartt-Event-Image-2.jpg"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: ""
        }
    }

    Column {
        anchors.fill: parent

        Snsbar {
            id: snsBar
            width: parent.width
            height: 30
        }

        Rectangle {
            id: coverPanel
            width: parent.width
            height: width * 0.4

            Image {
                anchors.fill: parent
                source: coverImage
            }
        }

        Rectangle {
            id: articlePanel
            width: parent.width
            height: contentPanel.height

            Rectangle {
                id: contentPanel
                width: {
                    if (articlePanel.width >= 700) {
                        return 700
                    }

                    return articlePanel.width * 0.85
                }
                height: spacerHeader.height
                        + articleContentPanel.height
                        + spacerFooter.height
                anchors.horizontalCenter: parent.horizontalCenter

                Column {
                    anchors.fill: parent

                    Item {
                        id: spacerHeader
                        width: parent.width
                        height: 100
                    }

                    Item {
                        id: articleContentPanel
                        width: parent.width
                        height: contentLayout.height

                        Column {
                            id: contentLayout
                            spacing: 40

                            Repeater {
                                model: contentModel
                                delegate: Item {
                                    id: contentDelegate

                                    function updateGeometry() {
                                        var item = loader.item

                                        if ("img" === type) {
                                            item.source = content
                                            item.width = qmlWidth(contentPanel.width)
                                            contentDelegate.height = item.height
                                            item.centerIn = contentDelegate
                                        } else if ("txt" === type) {
                                            item.text = content
                                            item.width = qmlWidth(contentPanel.width)
                                            contentDelegate.height = item.height
                                        } else if ("sectionHeader" === type) {
                                            item.text = content
                                            item.width = qmlWidth(contentPanel.width)
                                            contentDelegate.height = item.height + 50
                                            item.anchors.bottom = contentDelegate.bottom
                                        } else if ("AD_1" === type) {
                                            if (mainWindow.width >= 1000) {
                                                item.width = contentPanel.width * 1.2
                                            } else {
                                                item.width = qmlWidth(contentPanel.width * 0.9)
                                            }
                                            contentDelegate.height = item.height + 50
                                            item.anchors.left = contentDelegate.left
                                            item.anchors.verticalCenter = contentDelegate.verticalCenter
                                        } else if ("AD_2" === type) {
                                            if (mainWindow.width >= 1000) {
                                                item.width = contentPanel.width * 1.2
                                            } else {
                                                item.width = qmlWidth(contentPanel.width * 0.9)
                                            }
                                            contentDelegate.height = item.height + 50
                                            item.anchors.left = contentDelegate.left
                                            item.anchors.verticalCenter = contentDelegate.verticalCenter
                                        }
                                    }

                                    width: contentPanel.width

                                    Connections {
                                        target: mainWindow
                                        onWidthChanged: {
                                            if (loader.inited) {
                                                contentDelegate.updateGeometry()
                                            }
                                        }
                                    }

                                    Loader {
                                        id: loader

                                        property bool inited: false
                                    }

                                    Component.onCompleted: {
                                        loader.loaded.connect(function () {
                                            loader.inited = true
                                            updateGeometry()
                                        })

                                        if ("img" === type) {
                                            loader.source = "../qml/article/ImageComp.qml"
                                        } else if ("txt" === type) {
                                            loader.source = "../qml/article/TextComp.qml"
                                        } else if ("sectionHeader" === type) {
                                            loader.source = "../qml/article/SectionHeaderComp.qml"
                                        } else if ("AD_1" === type) {
                                            loader.source = "../qml/article/AD_1.qml"
                                        } else if ("AD_2" === type) {
                                            loader.source = "../qml/article/AD_2.qml"
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Item {
                        id: spacerFooter
                        width: parent.width
                        height: 100
                    }
                }
            }
        }
    }
}
