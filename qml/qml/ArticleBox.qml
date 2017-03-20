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
        articleModel.clear()
        for (i in articles) {
            articleModel.append(articles[i])
        }
        articlesPanel.height = mainWindow.channelHeight * articleModel.count
        mainWindow.height = notifyBar.height + articlesPanel.height

        var bubble = "您已发布文章" + articles.length + "篇"
        showNotificationBubble(true, bubble)
    }

    function changeArticleStatus(idx, articleId, status) {
        var url = "account/updateArticle"
        var body = {}
        body.articleId = articleId
        body.status = status
        network.httpPost(url, body, function(res) {
            try {
                var article = JSON.parse(res)
                // check if returned article is the one we want to modify
                if (articleModel.get(idx).articleId === article.articleId) {
                    articleModel.setProperty(idx, "status", status)
                }
            } catch(e) {
                console.log("JSON parse error(ArticleBox.qml changeArticleStatus): ", e)
            }
        })
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
                    height: 18
                    anchors.centerIn: parent
                    font.pixelSize: 16
                    color: "white"
                    onTextChanged: {
                        notifyText.width = notifyText.dom.firstChild.offsetWidth
                    }
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

                        GeneralMouseArea {
                            onEntered: {
                                hoverBg.visible = true
                            }
                            onExited: {
                                hoverBg.visible = false
                            }
                            onClicked: {
                            }
                        }

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
                                    var newStatus = status
                                    if ("private" === status) {
                                        newStatus = "draft"
                                    } else if ("public" === status) {
                                        newStatus = "private"
                                    } else if ("draft" === status) {
                                        newStatus = "public"
                                    }

                                    // mainWindow.changeArticleStatus(index, articleId, newStatus)
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
                    }
                }
            }
        }
    }
}
