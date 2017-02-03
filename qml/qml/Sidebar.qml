import QtQuick 2.5
import QtGraphicalEffects 1.0

Rectangle {
    id: sideBar
    width: 400
    height: parent.height

    Column {
        anchors.fill: parent

        Item {
            id: spacer1
            width: parent.width
            height: 25
        }

        Item {
            width: 360
            height: 400
            anchors.horizontalCenter: parent.horizontalCenter

            RectangularGlow {
                id: effect
                anchors.fill: logoPanel
                glowRadius: 1
                spread: 0.2
                color: "#d8d8d8"
                cornerRadius: logoPanel.radius + glowRadius
            }

            Rectangle {
                id: logoPanel
                width: 360
                height: 400
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 10
                color: "#333333"

                Column {
                    anchors.fill: parent

                    Item {
                        width: parent.width
                        height: parent.height - profilePanel.height
                        anchors.horizontalCenter: parent.horizontalCenter

                        Image {
                            id: logoImg
                            width: 80
                            height: 80
                            anchors.top: parent.top
                            anchors.topMargin: 40
                            anchors.horizontalCenter: parent.horizontalCenter
                            source: "../imgs/logo.png"
                        }

                        Text {
                            id: jcText
                            anchors.top: logoImg.bottom
                            anchors.topMargin: 40
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 30
                            font.family: "Krugthep"
                            color: "white"
                            text: "Pattern Finance"
                        }

                        Text {
                            anchors.top: jcText.bottom
                            anchors.topMargin: 10
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 12
                            color: "white"
                            text: "发现能持续获利的投资模式"
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                Qt.openUrlExternally("https://www.patternfinance.com")
                            }
                        }
                    }

                    Rectangle {
                        id: profilePanel
                        width: parent.width
                        height: 150
                        anchors.horizontalCenter: parent.horizontalCenter

                        Rectangle {
                            id: imgItem
                            width: 70
                            height: 70
                            anchors.top: parent.top
                            anchors.topMargin: 1
                            anchors.left: parent.left
                            anchors.leftMargin: 1

                            Image {
                                width: 50
                                height: 50
                                anchors.centerIn: parent
                                source: "../imgs/preloader.gif"
                            }
                        }

                        Text {
                            anchors.top: imgItem.top
                            anchors.topMargin: 10
                            anchors.left: imgItem.right
                            anchors.leftMargin: 5
                            font.pixelSize: 18
                            color: "#4a4a4a"
                            text: "Gimletech"
                        }

                        Text {
                            anchors.top: imgItem.top
                            anchors.topMargin: 40
                            anchors.left: imgItem.right
                            anchors.leftMargin: 5
                            font.pixelSize: 14
                            color: "#4a4a4a"
                            text: "用量化分析和可视化数据解读投资"
                        }

                        Text {
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 37
                            anchors.horizontalCenter: wzzsText.horizontalCenter
                            font.pixelSize: 18
                            color: "#4a4a4a"
                            text: "160"
                        }

                        Text {
                            id: wzzsText
                            anchors.left: parent.left
                            anchors.leftMargin: 7
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 10
                            font.pixelSize: 14
                            color: "#4a4a4a"
                            text: "文章总数"
                        }
                    }
                }
            }
        }

        Item {
            id: spacer2
            width: parent.width
            height: 180
        }

        Rectangle {
            id: recommArticlePanel
            width: 300
            height: 160
            anchors.horizontalCenter: parent.horizontalCenter

            Column {
                anchors.fill: parent

                Item {
                    id: recommTitleBar
                    width: parent.width
                    height: 30

                    Text {
                        font.pixelSize: 16
                        color: "#4a4a4a"
                        text: "推荐阅读"
                    }

                    Rectangle {
                        width: parent.width
                        height: 3
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "#5B7FA2"
                    }
                }

                Item {
                    id: aSpacer
                    width: parent.width
                    height: 21
                }

                Item {
                    id: aListItem
                    width: parent.width
                    height: parent.height
                            - recommTitleBar.height
                            - aSpacer.height

                    Column {
                        anchors.fill: parent
                        spacing: 10

                        Repeater {
                            model: ListModel {
                                ListElement {
                                    aTitle: "怎样确定投资机会？"
                                }
                                ListElement {
                                    aTitle: "实时监控系统性风险"
                                }
                                ListElement {
                                    aTitle: "均值回归策略都可以怎么用？"
                                }
                            }
                            delegate: Item {
                                width: recommArticlePanel.width
                                height: 30

                                Image {
                                    width: 30
                                    height: 30
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                    source: "../imgs/n" + (index+1) + ".png"
                                }

                                Text {
                                    anchors.top: parent.top
                                    anchors.topMargin: 5
                                    anchors.left: parent.left
                                    anchors.leftMargin: 40
                                    font.pixelSize: 16
                                    color: "#4a4a4a"
                                    text: aTitle
                                }
                            }
                        }
                    }
                }
            }
        }

        Item {
            id: spacer3
            width: parent.width
            height: 100
        }

        Rectangle {
            id: recommBookPanel
            width: 300
            height: 600
            anchors.horizontalCenter: parent.horizontalCenter

            Column {
                anchors.fill: parent

                Item {
                    id: rBookTitleBar
                    width: parent.width
                    height: 30

                    Text {
                        font.pixelSize: 16
                        color: "#4a4a4a"
                        text: "精选书籍"
                    }

                    Rectangle {
                        width: parent.width
                        height: 3
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "#5B7FA2"
                    }
                }

                Item {
                    id: bSpacer
                    width: parent.width
                    height: 30
                }

                Item {
                    width: parent.width
                    height: 600 * 3

                    Column {
                        anchors.fill: parent
                        spacing: 100

                        Repeater {
                            model: ListModel {
                                ListElement {
                                    cover: "../imgs/books/gpzshyl.jpg"
                                }
                                ListElement {
                                    cover: "../imgs/books/buffettzhidao.jpg"
                                }
                                ListElement {
                                    cover: "../imgs/books/dabaijuheji.jpg"
                                }
                                ListElement {
                                    cover: "../imgs/books/daqindiguo.jpg"
                                }
                                ListElement {
                                    cover: "../imgs/books/gdjzjqj.jpg"
                                }
                                ListElement {
                                    cover: "../imgs/books/ygzqfxsdxw.jpg"
                                }
                                ListElement {
                                    cover: "../imgs/books/wujinglianzhuan.jpg"
                                }
                                ListElement {
                                    cover: "../imgs/books/shbs.jpg"
                                }
                                ListElement {
                                    cover: "../imgs/books/moguijingjixue.jpg"
                                }
                                ListElement {
                                    cover: "../imgs/books/lianxidexintai.jpg"
                                }
                            }

                            delegate: Item {
                                width: recommBookPanel.width
                                height: 435

                                Column {
                                    anchors.fill: parent

                                    Image {
                                        id: bookCoverImg
                                        width: 350
                                        height: 350
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        source: cover
                                    }

                                    Item {
                                        id: spacer0
                                        width: parent.width
                                        height: 20
                                    }

                                    Item {
                                        id: jdzyEntry
                                        width: parent.width
                                        height: 65

                                        Image {
                                            width: 67
                                            height: 30
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            source: "../imgs/jdzy.png"
                                        }

                                        Rectangle {
                                            width: 100
                                            height: 30
                                            anchors.bottom: parent.bottom
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            radius: 3
                                            color: "#F25352"

                                            Text {
                                                anchors.top: parent.top
                                                anchors.topMargin: 4
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                font.pixelSize: 16
                                                color: "white"
                                                text: "直达链接"
                                            }
                                        }

                                        MouseArea {
                                            anchors.fill: parent
                                            cursorShape: Qt.PointingHandCursor
                                            onClicked: {
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        width: 1
        height: parent.height
        anchors.top: parent.top
        anchors.left: parent.left
        // color: "#efefef"
    }
}
