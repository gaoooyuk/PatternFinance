import QtQuick 2.5

Rectangle {
    id: articleEditPanel
    width: parent.width
    height: articleEditRow1.height
            + articleEditRow2.height
            + articleEditRow3.height
            + articleEditBottomBar.height
            + spacer.height

    property string baseColor: "#52D57A"

    signal dismiss()
    signal saveMetaRequest(var meta)

    function saveArticleMeta() {
        var meta = {}
        meta.title = valInput1.text
        meta.category =valInput2.text
        meta.status = "public"
        if ("私有文章" === valInput3.text) {
            meta.status = "private"
        } else if ("存入草稿" === valInput3.text) {
            meta.status = "draft"
        }
        meta.lede = valInput4.text

        articleEditPanel.saveMetaRequest(meta)
    }

    Column {
        anchors.fill: parent

        Item {
            id: articleEditRow1
            width: parent.width
            height: 60

            Row {
                anchors.fill: parent

                Item {
                    width: parent.width / 2
                    height: parent.height

                    Text {
                        width: 32
                        height: 18
                        anchors.left: parent.left
                        anchors.leftMargin: 30
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 16
                        color: "#4a4a4a"
                        text: "标题"
                    }

                    TextInput {
                        id: valInput1
                        width: parent.width - anchors.leftMargin - 20
                        height: 18
                        anchors.top: parent.top
                        anchors.topMargin: 21
                        anchors.left: parent.left
                        anchors.leftMargin: 80
                        font.pixelSize: 16
                        color: articleEditPanel.baseColor
                        text: title
                    }

                    Rectangle {
                        width: valInput1.width
                        height: 2
                        color: valInput1.text.length > 0
                               ? articleEditPanel.baseColor
                               : "#f1f1f1"
                        anchors.top: valInput1.bottom
                        anchors.topMargin: 2
                        anchors.left: valInput1.left
                        opacity: 0.5
                    }
                }

                Item {
                    width: parent.width / 4
                    height: parent.height

                    Text {
                        width: 32
                        height: 18
                        anchors.left: parent.left
                        anchors.leftMargin: 30
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 16
                        color: "#4a4a4a"
                        text: "专栏"
                    }

                    Text {
                        id: valInput2
                        width: parent.width - anchors.leftMargin - 10
                        height: 18
                        anchors.top: parent.top
                        anchors.topMargin: 21
                        anchors.left: parent.left
                        anchors.leftMargin: 80
                        font.pixelSize: 16
                        color: articleEditPanel.baseColor

                        GeneralMouseArea {
                            onClicked: {
                                if ("物是评测" === valInput2.text) {
                                    valInput2.text = "磨石研究"
                                } else if ("磨石研究" === valInput2.text) {
                                    valInput2.text = "金融帝国"
                                } else if ("金融帝国" === valInput2.text) {
                                    valInput2.text = "投资故事"
                                } else if ("投资故事" === valInput2.text) {
                                    valInput2.text = "物是评测"
                                }
                            }
                        }

                        Component.onCompleted: {
                            var css = valInput2.dom.firstChild.style
                            css.borderBottom = "2px dashed #52D57A"
                            valInput2.text = category
                        }
                    }
                }

                Item {
                    width: parent.width / 4
                    height: parent.height

                    Text {
                        width: 64
                        height: 18
                        anchors.left: parent.left
                        anchors.leftMargin: 30
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 16
                        color: "#4a4a4a"
                        text: "文章状态"
                    }

                    Text {
                        id: valInput3
                        width: parent.width - anchors.leftMargin - 10
                        height: 18
                        anchors.top: parent.top
                        anchors.topMargin: 21
                        anchors.left: parent.left
                        anchors.leftMargin: 112
                        font.pixelSize: 16
                        color: articleEditPanel.baseColor

                        GeneralMouseArea {
                            onClicked: {
                                if ("公开访问" === valInput3.text) {
                                    valInput3.text = "私有文章"
                                } else if ("私有文章" === valInput3.text) {
                                    valInput3.text = "存入草稿"
                                } else if ("存入草稿" === valInput3.text) {
                                    valInput3.text = "公开访问"
                                }
                            }
                        }

                        Component.onCompleted: {
                            var css = valInput3.dom.firstChild.style
                            css.borderBottom = "2px dashed #52D57A"

                            if ("public" === status) {
                                valInput3.text = "公开访问"
                            } else if ("private" === status) {
                                valInput3.text = "私有文章"
                            } else if ("draft" === status) {
                                valInput3.text = "存入草稿"
                            } else {
                                valInput3.text = "公开访问"
                            }
                        }
                    }
                }
            }
        }

        Item {
            id: articleEditRow2
            width: parent.width
            height: 60

            Row {
                anchors.fill: parent

                Item {
                    width: parent.width
                    height: parent.height

                    Text {
                        width: 32
                        height: 18
                        anchors.left: parent.left
                        anchors.leftMargin: 30
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 16
                        color: "#4a4a4a"
                        text: "摘要"
                    }

                    TextInput {
                        id: valInput4
                        width: parent.width - anchors.leftMargin - 20
                        height: 18
                        anchors.top: parent.top
                        anchors.topMargin: 21
                        anchors.left: parent.left
                        anchors.leftMargin: 80
                        font.pixelSize: 16
                        color: articleEditPanel.baseColor
                    }

                    Rectangle {
                        width: valInput4.width
                        height: 2
                        color: valInput4.text.length > 0
                               ? articleEditPanel.baseColor
                               : "#f1f1f1"
                        anchors.top: valInput4.bottom
                        anchors.topMargin: 2
                        anchors.left: valInput4.left
                        opacity: 0.5
                    }

                    Component.onCompleted: {
                        valInput4.text = lede
                    }
                }
            }
        }

        Item {
            id: articleEditRow3
            width: parent.width
            height: 60

            Row {
                anchors.fill: parent

                Item {
                    width: parent.width
                    height: parent.height

                    Text {
                        width: 64
                        height: 18
                        anchors.left: parent.left
                        anchors.leftMargin: 30
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 16
                        color: "#4a4a4a"
                        text: "封面图片"
                    }
                }
            }
        }

        Item {
            id: articleEditBottomBar
            width: parent.width
            height: 60

            Rectangle {
                width: 60
                height: 32
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.verticalCenter: parent.verticalCenter
                radius: width / 2
                color: articleEditPanel.baseColor

                Text {
                    width: 32
                    height: 18
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 16
                    font.bold: true
                    color: "white"
                    text: "保存"
                }

                GeneralMouseArea {
                    onClicked: {
                        // TODO
                        articleEditPanel.saveArticleMeta()
                        articleEditPanel.dismiss()
                    }
                }
            }

            Rectangle {
                width: 60
                height: 32
                anchors.left: parent.left
                anchors.leftMargin: 85
                anchors.verticalCenter: parent.verticalCenter
                radius: width / 2

                Text {
                    width: 32
                    height: 18
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 16
                    font.bold: true
                    color: "#8a8a8a"
                    text: "取消"
                }

                GeneralMouseArea {
                    onClicked: {
                        articleEditPanel.dismiss()
                    }
                }
            }

            Rectangle {
                width: 128
                height: 32
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                radius: width / 2

                Text {
                    width: 128
                    height: 18
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 16
                    color: "#8a8a8a"
                    text: "进入文章内容编辑"
                }

                GeneralMouseArea {
                    onClicked: {
                    }
                }
            }
        }

        Item {
            id: spacer
            width: parent.width
            height: 60
        }
    }
}
