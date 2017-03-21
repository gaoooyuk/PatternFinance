import QtQuick 2.5

Rectangle {
    id: publishBox
    width: 300
    height: 400
    radius: 4

    property int stage: 0 // 0-发布提醒  1-编辑发布平台 2-添加和编辑文章标签
    property string baseColor: "#52D57A"
    property bool publishing: false

    signal publishRequest()

    GeneralMouseArea {
        cursorShape: Qt.ArrowCursor
    }

    Column {
        anchors.fill: parent

        Item {
            id: stageTitle
            width: 280
            height: 60
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                width: 250
                anchors.top: parent.top
                anchors.topMargin: 15
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                font.pixelSize: 20
                color: "#4a4a4a"
                text: {
                    if (1 === publishBox.stage) {
                        return "发布平台"
                    } else if (2 === publishBox.stage) {
                        return "文章标签"
                    }

                    return "准备发布"
                }
            }
        }

        Item {
            id: stagePanel
            width: parent.width
            height: parent.height - stageTitle.height

            Item {
                id: stage0Panel
                anchors.fill: parent
                visible: 0 === publishBox.stage

                Column {
                    anchors.fill: parent

                    Item {
                        width: parent.width
                        height: 60

                        Text {
                            width: 250
                            anchors.horizontalCenter: parent.horizontalCenter
                            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                            font.pixelSize: 16
                            color: "#4a4a4a"
                            text: "您的文章即将发布到包括<strong>磨石金融</strong>在内的5个内容平台"
                        }
                    }

                    Item {
                        id: publishOptions
                        width: 280
                        height: 215
                        anchors.horizontalCenter: parent.horizontalCenter

                        Text {
                            width: 250
                            anchors.top: parent.top
                            anchors.topMargin: 20
                            anchors.horizontalCenter: parent.horizontalCenter
                            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                            font.pixelSize: 16
                            color: "#4a4a4a"
                            text: "在发布前您还可以："
                        }

                        Rectangle {
                            id: platformEdit
                            width: 270
                            height: 35
                            anchors.top: parent.top
                            anchors.topMargin: 80
                            anchors.horizontalCenter: parent.horizontalCenter
                            radius: 2

                            Text {
                                width: 250
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                anchors.verticalCenter: parent.verticalCenter
                                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                font.pixelSize: 15
                                color: "#6772e5"
                                text: "编辑发布平台"
                            }

                            GeneralMouseArea {
                                onEntered: {
                                    platformEdit.color = "#f8f8f8"
                                }
                                onExited: {
                                    platformEdit.color = "white"
                                }
                                onClicked: {
                                    publishBox.stage = 1
                                }
                            }
                        }

                        Rectangle {
                            id: tagEdit
                            width: 270
                            height: 35
                            anchors.top: platformEdit.bottom
                            anchors.topMargin: 5
                            anchors.horizontalCenter: parent.horizontalCenter
                            radius: 2

                            Text {
                                width: 250
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                anchors.verticalCenter: parent.verticalCenter
                                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                font.pixelSize: 15
                                color: "#6772e5"
                                text: "添加和编辑文章标签"
                            }

                            GeneralMouseArea {
                                onEntered: {
                                    tagEdit.color = "#f8f8f8"
                                }
                                onExited: {
                                    tagEdit.color = "white"
                                }
                                onClicked: {
                                    publishBox.stage = 2
                                }
                            }
                        }
                    }

                    Item {
                        id: publishBtn
                        width: 280
                        height: 60
                        anchors.horizontalCenter: parent.horizontalCenter

                        Rectangle {
                            width: 280
                            height: 48
                            anchors.centerIn: parent
                            radius: 5
                            color: publishBox.publishing
                                   ? "#9b9b9b"
                                   : publishBox.baseColor

                            Text {
                                width: 40
                                height: 23
                                anchors.centerIn: parent
                                font.pixelSize: 20
                                font.bold: true
                                color: "white"
                                text: "发布"
                            }
                        }

                        GeneralMouseArea {
                            onClicked: {
                                if (publishBox.publishing) {
                                    return
                                }

                                publishBox.publishing = true
                                publishBox.publishRequest()
                            }
                        }
                    }
                }
            }

            Item {
                id: stage1Panel
                anchors.fill: parent
                visible: 1 === publishBox.stage

                Column {
                    anchors.fill: parent

                    Item {
                        width: parent.width
                        height: parent.height - stage1BottomBar.height
                    }

                    Item {
                        id: stage1BottomBar
                        width: parent.width
                        height: 60

                        Rectangle {
                            width: 60
                            height: 32
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            anchors.verticalCenter: parent.verticalCenter
                            radius: width / 2
                            color: publishBox.baseColor

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
                                    publishBox.stage = 0
                                }
                            }
                        }

                        Rectangle {
                            width: 60
                            height: 32
                            anchors.left: parent.left
                            anchors.leftMargin: 80
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
                                    publishBox.stage = 0
                                }
                            }
                        }
                    }
                }
            }

            Item {
                id: stage2Panel
                anchors.fill: parent
                visible: 2 === publishBox.stage

                Column {
                    anchors.fill: parent

                    Item {
                        width: parent.width
                        height: parent.height - stage2BottomBar.height
                    }

                    Item {
                        id: stage2BottomBar
                        width: parent.width
                        height: 60

                        Rectangle {
                            width: 60
                            height: 32
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            anchors.verticalCenter: parent.verticalCenter
                            radius: width / 2
                            color: publishBox.baseColor

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
                                    publishBox.stage = 0
                                }
                            }
                        }

                        Rectangle {
                            width: 60
                            height: 32
                            anchors.left: parent.left
                            anchors.leftMargin: 80
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
                                    publishBox.stage = 0
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}



