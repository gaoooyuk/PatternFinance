import QtQuick 2.5
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0

Rectangle {
    id: mainWindow
    width: parent.width
    height: notifyBar.height + articlesPanel.height

    property int channelWidth: 500
    property int channelHeight: 80
    property int channelSpacing: 10

    function showNotificationBubble(success, content) {
        notifyBubble.source = "../imgs/dashboard/pSuccess.png"
        if (!success) {
            notifyBubble.source = "../imgs/dashboard/pFail.png"
        }
        notifyText.text = content
    }

    function listArticles(articles) {
        console.log("listArticles: ", articles.length)
        articleModel.clear()
        for (i in articles) {
            articleModel.append(articles[i])
        }
        articlesPanel.height = mainWindow.channelHeight * articleModel.count
        mainWindow.height = notifyBar.height + articlesPanel.height
    }

    ListModel {
        id: articleModel
    }

    Column {
        anchors.fill: parent

        Rectangle {
            id: notifyBar
            width: parent.width
            height: 200

            Image {
                id: notifyBubble
                width: mainWindow.channelWidth
                height: 48
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: notifyText
                    width: 112
                    height: 18
                    anchors.centerIn: parent
                    font.pixelSize: 16
                    color: "white"
                }
            }
        }

        Rectangle {
            id: articlesPanel
            width: {
                if (mainWindow.width >= 800) {
                    return 800
                }

                return mainWindow.width * 0.85
            }
            anchors.horizontalCenter: parent.horizontalCenter
            height: itemLayout.height

            Column {
                id: itemLayout
                anchors.fill: parent

                Repeater {
                    id: repeater
                    model: articleModel
                    delegate: Rectangle {
                        id: articleDelegate

                        property int lMargin: 100

                        width: articlesPanel.width
                        height: mainWindow.channelHeight

                        Rectangle {
                            id: hoverBg
                            width: parent.width
                            height: parent.height
                            anchors.centerIn: parent
                            radius: 5
                            visible: false
                            color: "#a5bad8"
                            opacity: 0.1
                        }

                        Text {
                            id: visibilityText
                            width: 28
                            height: 16
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 14
                            color: "#9b9b9b"
                            text: "private" === status
                                  ? "私有"
                                  : "draft" === status
                                    ? "草稿"
                                    : "公开"

                            GeneralMouseArea {
                                onClicked: {
                                }
                            }

                            Component.onCompleted: {
                                var css = visibilityText.dom.firstChild.style
                                css.borderBottom = "2px dotted #d8d8d8"
                            }
                        }

                        Text {
                            id: textItem
                            width: articlesPanel.width - textItem.anchors.leftMargin - 10
                            anchors.top: parent.top
                            anchors.topMargin: 6
                            anchors.left: parent.left
                            anchors.leftMargin: articleDelegate.lMargin
                            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                            font.pixelSize: 18
                            color: "#5DC4EA"
                            text: title
                        }

                        Text {
                            id: textSummaryItem
                            width: articlesPanel.width - textSummaryItem.anchors.leftMargin - 10
                            anchors.top: textItem.bottom
                            anchors.topMargin: 5
                            anchors.left: parent.left
                            anchors.leftMargin: articleDelegate.lMargin
                            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                            font.pixelSize: 14
                            color: "#4a4a4a"
                            text: lede
                        }

                        GeneralMouseArea {
                            onEntered: {
                                hoverBg.visible = true
                            }
                            onExited: {
                                hoverBg.visible = false
                            }
                            onClicked: {
                                Qt.openUrlExternally("/article/" + articleId)
                            }
                        }
                    }
                }
            }
        }
    }
}
