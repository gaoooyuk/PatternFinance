import QtQuick 2.5

Rectangle {
    id: shareBar
    width: 80
    height: 265

    property int numberOfShares: 0
    property string articleId: ""
    property string articleUrl: ""
    property string articleTitle: ""
    property string articleCover: ""

    function share2weibo(url, title, image) {
        var baseUrl = "http://service.weibo.com/share/share.php?"
        baseUrl += ("url=" + url)
        baseUrl += "&"
        baseUrl += ("title=" + title)
        baseUrl += "&"
        baseUrl += ("pic=" + image)

        Qt.openUrlExternally(baseUrl)
    }

    function share2qzone(url, title, image) {
        var baseUrl = "http://connect.qq.com/widget/shareqq/index.html?"
        baseUrl += ("url=" + url)
        baseUrl += "&"
        baseUrl += ("title=" + title)
        baseUrl += "&"
        baseUrl += ("source=" + title)
        baseUrl += "&"
        baseUrl += ("desc=" + title)
        baseUrl += "&"
        baseUrl += ("pics=" + image)

        Qt.openUrlExternally(baseUrl)
    }

    function share2weixin() {

    }

    function share2linkedin(url, title, image) {
        var baseUrl = "http://www.linkedin.com/shareArticle?mini=true&ro=true&"
        baseUrl += ("url=" + url)
        baseUrl += "&"
        baseUrl += ("title=" + title)
        baseUrl += "&"
        baseUrl += ("summary=" + title)
        baseUrl += "&"
        baseUrl += ("source=" + title)
        baseUrl += "&armin=armin"

        Qt.openUrlExternally(baseUrl)
    }

    function share2douban(url, title, image) {
        var baseUrl = "http://shuo.douban.com/!service/share?"
        baseUrl += ("href=" + url)
        baseUrl += "&"
        baseUrl += ("name=" + title)
        baseUrl += "&"
        baseUrl += ("text=" + title)
        baseUrl += "&"
        baseUrl += ("image=" + image)
        baseUrl += "&starid=0&aid=0&style=11"

        Qt.openUrlExternally(baseUrl)
    }

    function share2twitter(url, title, image) {
        var baseUrl = "https://twitter.com/intent/tweet?"
        baseUrl += ("text=" + title)
        baseUrl += "&"
        baseUrl += ("url=" + url)
        baseUrl += "&"
        baseUrl += ("via=" + "https://www.patternfinance.com")

        Qt.openUrlExternally(baseUrl)
    }

    function updateSharesCount() {
        var url = "http://localhost:8110/api/addSharesCount4Article"
        var body = {}
        body.articleId = shareBar.articleId
        network.httpPost(url, body, function(res) {
        })
    }

    Network {
        id: network
    }

    Text {
        id: sharesCountText
        anchors.left: parent.left
        font.pixelSize: 20
        font.bold: true
        color: "#4a4a4a"
        text: shareBar.numberOfShares
    }

    Text {
        anchors.top: parent.top
        anchors.topMargin: 24
        anchors.left: parent.left
        font.pixelSize: 16
        font.bold: true
        color: "#9b9b9b"
        text: "SHARES"
    }

    Item {
        anchors.top: parent.top
        anchors.topMargin: 60

        Column {
            anchors.fill: parent
            spacing: 10

            Repeater {
                model: ListModel {
                    ListElement {
                        sns: "weibo"
                    }
                    ListElement {
                        sns: "weixin"
                    }
                    ListElement {
                        sns: "twitter"
                    }
                    ListElement {
                        sns: "linkedin"
                    }
                    ListElement {
                        sns: "douban"
                    }
                    ListElement {
                        sns: "qzone"
                    }
                }

                delegate: Item {
                    width: 25
                    height: 25

                    Image {
                        id: sbImg
                        width: 25
                        height: 25
                        anchors.centerIn: parent
                        source: "../imgs/" + sns + ".png"
                    }

                    Image {
                        id: sbEnabledImg
                        width: 25
                        height: 25
                        anchors.centerIn: parent
                        source: "../imgs/" + sns + "c.png"
                        visible: false
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onEntered: {
                            sbEnabledImg.visible = true
                        }
                        onExited: {
                            sbEnabledImg.visible = false
                        }
                        onClicked: {
                            updateSharesCount()

                            if ("weibo" === sns) {
                                share2weibo(shareBar.articleUrl,
                                            shareBar.articleTitle,
                                            shareBar.articleCover)
                            } else if ("weixin" === sns) {

                            } else if ("twitter" === sns) {
                                share2twitter(shareBar.articleUrl,
                                            shareBar.articleTitle,
                                            shareBar.articleCover)
                            } else if ("linkedin" === sns) {
                                share2linkedin(shareBar.articleUrl,
                                            shareBar.articleTitle,
                                            shareBar.articleCover)
                            } else if ("douban" === sns) {
                                share2douban(shareBar.articleUrl,
                                            shareBar.articleTitle,
                                            shareBar.articleCover)
                            } else if ("qzone" === sns) {
                                share2qzone(shareBar.articleUrl,
                                            shareBar.articleTitle,
                                            shareBar.articleCover)
                            }
                        }
                    }
                }
            }
        }
    }
}
