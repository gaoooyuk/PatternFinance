import QtQuick 2.5

Rectangle {
    id: mainWindow

    property string channelName: ""
    property string coverImage: ""
    property string apiBase: "/api"

    function qmlWidth(w) {
        return w + 1
    }

    function qmlHeight(h) {
        return h + 1
    }

    function qmlContentHeight() {
        var h = 0
        for (var i = 1; i < contentLayout.children.length; i++) {
            h += contentLayout.children[i].height
        }

        h += contentLayout.spacing * contentLayout.children.length

        return h
    }

    function loadArticle(n) {
        var url = apiBase + "/getChannelArticles"
        var req = {}
        req.num = 10
        req.category = mainWindow.channelName
        network.httpPost(url, req, function(res) {
            try {
                var articles = JSON.parse(res)
                for (var i = 0; i < articles.length; i++) {
                    articleModel.append(articles[i])
                }
            } catch(e) {
                console.log("JSON parse error(ChannelBase.qml getChannelArticles): ", e)
            }
        })
    }

    height: snsBar.height
            + coverPanel.height
            + articlePanel.height

    Network {
        id: network
    }

    ListModel {
        id: articleModel
    }

    Column {
        anchors.fill: parent

        Rectangle {
            id: snsBar
            width: parent.width
            height: 30
            color: "#1a1a1a"
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
            height: articleTopItem.height
                    + articleContentPanel.height
                    + articleBottomItem.height

            Rectangle {
                id: contentPanel
                width: {
                    if (articlePanel.width >= 700) {
                        return 700
                    }

                    return articlePanel.width * 0.85
                }
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter

                Column {
                    anchors.fill: parent

                    Item {
                        id: articleTopItem
                        width: parent.width
                        height: 60
                    }

                    Item {
                        id: articleContentPanel
                        width: parent.width
                        height: qmlContentHeight()

                        Column {
                            id: contentLayout
                            anchors.fill: parent
                            spacing: {
                                if (mainWindow.width >= 750) {
                                    return 30
                                }

                                return 20
                            }

                            Repeater {
                                id: articleRepeater
                                model: articleModel
                                delegate: Item {
                                    width: contentPanel.width
                                    height: textItem.height + textSummaryItem.height + 20

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
                                        id: textItem
                                        width: qmlWidth(contentPanel.width) - textItem.anchors.leftMargin - 10
                                        anchors.top: parent.top
                                        anchors.topMargin: 6
                                        anchors.left: parent.left
                                        anchors.leftMargin: 60
                                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                        font.pixelSize: 18
                                        color: "#5DC4EA"
                                        text: title
                                    }

                                    Text {
                                        id: textSummaryItem
                                        width: qmlWidth(contentPanel.width) - textSummaryItem.anchors.leftMargin - 10
                                        anchors.top: textItem.bottom
                                        anchors.topMargin: 5
                                        anchors.left: parent.left
                                        anchors.leftMargin: 60
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

                    Item {
                        id: articleBottomItem
                        width: parent.width
                        height: 60
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        loadArticle(10)
    }
}
