import QtQuick 2.5
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0

Rectangle {
    id: mainWindow
    height: spacer1.height + dbInner.height
    onHeightChanged: {
        var embed = document.getElementById('embed');
        if (embed) {
          embed.style.height = height + "px"
        }
    }

    property string apiBase: "/account"
    property var composerObj
    property var sentBoxObj
    property var articleInfo

    function publishArticle() {
        var url = apiBase + "/addArticle"
        network.httpPost(url, prepareArticleData(), function(res) {
            try {
                var json = JSON.parse(res)
                if (json.success) {
                    loader.loadSentBox()
                    if (mainWindow.sentBoxObj) {
                        mainWindow.sentBoxObj.showResultBubble(json)
                    }
                } else {
                    notifyBubble.source = "../imgs/dashboard/pFail.png"
                    notifyText.text = "文章未发布成功"
                }
            } catch(e) {
                console.log("JSON parse error(Dashboard.qml publishArticle): ", e)
            }
        })
    }

    function prepareArticleData() {
        var info = mainWindow.articleInfo
        var data = info
        data.rawData = mainWindow.composerObj.dumpArticle()
        return data
    }

    function shortUUID() {
        var ALPHABET = '23456789abdegjkmnpqrvwxyz';
        var ALPHABET_LENGTH = ALPHABET.length;

        var ID_LENGTH = 8
        var rtn = ''
        for (var i = 0; i < ID_LENGTH; i++) {
            rtn += ALPHABET.charAt(Math.floor(Math.random() * ALPHABET_LENGTH));
        }
        return rtn;
    }

    Network {
        id: network
    }

    Column {
        anchors.fill: parent

        Item {
            id: spacer1
            width: parent.width
            height: 60

            Rectangle {
                width: parent.width
                height: 1
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#f1f1f1"
            }
        }

        Item {
            id: dbInner
            width: parent.width
            height: 800

            Item {
                id: importPanel
                width: 600
                height: 450
                anchors.centerIn: parent

                Text {
                    id: newBtn
                    width: 120
                    height: 35
                    anchors.top: parent.top
                    anchors.topMargin: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 30
                    color: "#d8d8d8"
                    text: "新建文章"

                    GeneralMouseArea {
                        onEntered: {
                            newBtn.color = "#4a4a4a"
                        }
                        onExited: {
                            newBtn.color = "#d8d8d8"
                        }
                        onClicked: {
                            loader.loadComposer(null)
                        }
                    }
                }

                ImportBox {
                    id: importBox
                    anchors.top: parent.top
                    anchors.topMargin: 150
                    anchors.horizontalCenter: parent.horizontalCenter
                    onContentAvailable: {
                        loader.loadComposer(ct)
                    }

                    function setContent(importedContent) {
                        contentAvailable(importedContent)
                    }
                }

                Text {
                    width: 128
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 16
                    color: "#8a8a8a"
                    text: "查看我的文章列表"
                }
            }

            Loader {
                id: loader
                anchors.fill: parent

                function loadComposer(contentArray) {
                    loader.source = "Composer.qml"
                    var composer = loader.item
                    composer.heightChanged.connect(function() {
                        dbInner.height = composer.height
                    })
                    composer.articleInfoChanged.connect(function (info) {
                        mainWindow.articleInfo = info
                    })
                    mainWindow.composerObj = composer

                    // create default article info
                    var ai = {}
                    ai.id = shortUUID()
                    ai.author = "阿一西德卤"
                    ai.cover = "../imgs/dashboard/defaultCover.png"
                    ai.lede = ""
                    ai.category = "投资故事"
                    mainWindow.articleInfo = ai
                    composer.initArticleInfo(ai)
                    if (contentArray) {
                        composer.fillContentModel(contentArray)
                    }

                    composer.width = dbInner.width * 0.6
                    composer.anchors.top = dbInner.top
                    composer.anchors.horizontalCenter = dbInner.horizontalCenter
                    changePublishBtnVisibility(true)
                }

                function loadSentBox() {
                    loader.source = "SentBox.qml"
                    var sbox = loader.item
                    mainWindow.sentBoxObj = sbox
                    sbox.newArticleRequest.connect(function() {
                        loader.loadComposer(null)
                    })
                    sbox.width = dbInner.width
                    sbox.anchors.top = dbInner.top
                    sbox.anchors.horizontalCenter = dbInner.horizontalCenter
                    dbInner.height = sbox.height
                    changePublishBtnVisibility(false)
                }
            }

            PublishBox {
                id: publishBox
                anchors.top: parent.top
                visible: false
                onPublishRequest: {
                    mainWindow.publishArticle()
                }
            }

            Image {
                id: notifyBubble
                width: 500
                height: 48
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                visible: false

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
    }

    Component.onCompleted: {
    }
}
