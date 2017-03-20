import QtQuick 2.5
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0

Rectangle {
    id: mainWindow
    width: parent.width
    height: notifyBar.height + tabBar.height + articlesPanel.height

    property int channelWidth: 500
    property int channelHeight: 80
    property int channelSpacing: 10
    property bool editMode: false

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
            var article = articles[i]
            article.selected = false
            article.editing = false
            articleModel.append(article)
        }
        updateGeometry()

        var bubble = "您已发布文章" + articles.length + "篇"
        showNotificationBubble(true, bubble)
    }

    function updateGeometry() {
        var h = 0
        for (var i = 0; i < articleModel.count; i++) {
            if (articleModel.get(i).editing) {
                h += 300
            } else {
                h += mainWindow.channelHeight
            }
        }

        articlesPanel.height = h
        mainWindow.height = notifyBar.height + tabBar.height + articlesPanel.height
    }

    function updateArticle(idx, articleId, meta) {
        // console.log("updateArticle: ", meta)
        var url = "account/updateArticle"
        var body = {}
        body.articleId = articleId
        body.meta = meta
        network.httpPost(url, body, function(res) {
            try {
                var article = JSON.parse(res)
                // check if returned article is the one we want to modify
                if (articleModel.get(idx).articleId === article.articleId) {
                    for (k in article) {
                        articleModel.setProperty(idx, k, article[k])
                    }
                }
            } catch(e) {
                console.log("JSON parse error(ArticleBox.qml updateArticle): ", e)
            }
        })
    }

    ListModel {
        id: articleModel
    }

    ListModel {
        id: aeModel
        ListElement {
            key: "id"
            name: "标识"
            value: ""
        }
        ListElement {
            key: "author"
            name: "作者"
            value: ""
        }
        ListElement {
            key: "cover"
            name: "封面"
            value: ""
        }
        ListElement {
            key: "lede"
            name: "导言"
            value: ""
        }
        ListElement {
            key: "category"
            name: "专栏"
            value: ""
        }
    }

    Column {
        anchors.fill: parent

        Rectangle {
            id: notifyBar
            width: parent.width
            height: 160

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

        Item {
            id: tabBar
            width: articlesPanel.width
            height: 40
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                width: parent.width
                height: 2
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                color: "#fafafa"
            }

            Text {
                width: 64
                height: 16
                anchors.left: parent.left
                anchors.leftMargin: 5
                font.pixelSize: 16
                color: "#8a8a8a"
                text: "所有文章"
            }

            Text {
                width: 96
                height: 16
                anchors.right: parent.right
                anchors.rightMargin: 5
                font.pixelSize: 16
                color: "#8a8a8a"
                text: mainWindow.editMode
                      ? "退出编辑模式"
                      : "进入编辑模式"

                GeneralMouseArea {
                    onClicked: {
                        mainWindow.editMode = !mainWindow.editMode
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
                                if (mainWindow.editMode) {
                                    if (editLoader.hasEditor) {
                                        return
                                    }

                                    editLoader.hasEditor = true
                                    articleModel.setProperty(index, "editing", true)
                                    editLoader.source = "MetaEditorItem.qml"
                                    var metaEditor = editLoader.item
                                    metaEditor.saveMetaRequest.connect(function(meta) {
                                        mainWindow.updateArticle(index, articleId, meta)
                                    })

                                    metaEditor.dismiss.connect(function() {
                                        editLoader.source = ""
                                        editLoader.hasEditor = false
                                        articleModel.setProperty(index, "editing", false)
                                        articleDelegate.height = mainWindow.channelHeight
                                        mainWindow.updateGeometry()
                                    })
                                    articleDelegate.height = 300
                                    mainWindow.updateGeometry()
                                } else {
                                    var url = "/article/" + articleId
                                    Qt.openUrlExternally(url)
                                }
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

                        Loader {
                            id: editLoader
                            anchors.fill: parent
                            property bool hasEditor: false
                        }
                    }
                }
            }
        }
    }
}
