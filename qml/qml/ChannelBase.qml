import QtQuick 2.5

Rectangle {
    id: mainWindow

    property string channelName: ""
    property string coverImage: ""
    property string apiBase: "/api"

    property int articlesOnDisplay: 0
    property int lastHeightOnDisplay: 0

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
                mainWindow.articlesOnDisplay += articles.length
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

    onHeightChanged: {
        if (mainWindow.height !== mainWindow.lastHeightOnDisplay) {
            mainWindow.lastHeightOnDisplay = mainWindow.height

            if (mainWindow.articlesOnDisplay === articleModel.count) {
                Qt.updateGeometry(mainWindow.height)
            }
        }
    }

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

            Item {
                id: loginBtn
                width: 60
                height: parent.height
                anchors.right: parent.right

                Text {
                    id: loginText
                    height: 20
                    anchors.centerIn: parent
                    font.pixelSize: 14
                    color: "#c8c8c8"
                    text: "登录"
                }

                GeneralMouseArea {
                    onEntered: {
                        loginText.color = "white"
                    }
                    onExited: {
                        loginText.color = "#c8c8c8"
                    }
                }
            }

            Item {
                id: joinusBtn
                width: 60
                height: parent.height
                anchors.right: loginBtn.left

                Text {
                    id: joinusText
                    height: 20
                    anchors.centerIn: parent
                    font.pixelSize: 14
                    color: "#c8c8c8"
                    text: "加入我们"
                }

                GeneralMouseArea {
                    onEntered: {
                        joinusText.color = "white"
                    }
                    onExited: {
                        joinusText.color = "#c8c8c8"
                    }
                    onClicked: {
                        Qt.openUrlExternally("/joinus")
                    }
                }
            }

            Item {
                id: ptBtn
                width: 85
                height: parent.height
                anchors.right: joinusBtn.left

                Text {
                    id: ptText
                    height: 20
                    anchors.centerIn: parent
                    font.pixelSize: 14
                    color: "#c8c8c8"
                    text: "商务合作"
                }

                GeneralMouseArea {
                    onEntered: {
                        ptText.color = "white"
                    }
                    onExited: {
                        ptText.color = "#c8c8c8"
                    }
                    onClicked: {
                        Qt.openUrlExternally("/partners")
                    }
                }
            }

            Item {
                id: homeBtn
                width: 40
                height: parent.height
                anchors.right: ptBtn.left

                Text {
                    id: homeText
                    height: 20
                    anchors.centerIn: parent
                    font.pixelSize: 14
                    color: "#c8c8c8"
                    text: "首页"
                }

                GeneralMouseArea {
                    onEntered: {
                        homeText.color = "white"
                    }
                    onExited: {
                        homeText.color = "#c8c8c8"
                    }
                    onClicked: {
                        Qt.openUrlExternally("/")
                    }
                }
            }
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
                height: articleTopItem.height
                        + articleContentPanel.height
                        + articleBottomItem.height
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
                        height: contentLayout.height

                        Column {
                            id: contentLayout
                            spacing: {
                                if (mainWindow.width >= 750) {
                                    return 30
                                }

                                return 20
                            }

                            Repeater {
                                model: articleModel
                                delegate: Item {
                                    id: articleDelegate
                                    width: contentPanel.width
                                    height: textItem.height
                                            + textSummaryItem.height
                                            + 20

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
