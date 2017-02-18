import QtQuick 2.5

Rectangle {
    id: mainWindow

    property string coverImage: "../imgs/partner/bg.png"

    function qmlWidth(w) {
        return w + 1
    }

    function qmlHeight(h) {
        return h + 1
    }

    height: snsBar.height
            + coverPanel.height
            + articlePanel.height
            + liveChatPanel.height

    ListModel {
        id: contentModel
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "深度合作伙伴"
        }
        ListElement {
            type: "img"
            ratio: 0.3
            content: "../imgs/partner/Gimletech.png"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "Gimletech是一家初创的金融科技(Fintech)公司。总部位于英国伦敦。他们致力于使用机器学习算法和(金融)数据可视化来帮助证券投资者做决策。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "如果你对深度合作感兴趣，并且想与我们聊聊合作的可能性，请联系 <br>business@patternfinance.com"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "磨石金融合作伙伴计划"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "新媒体联盟计划"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "磨石金融的新媒体联盟计划专为<strong>自媒体</strong>和<strong>垂直媒体</strong>设计。加入该计划的自媒体除了可以获得内容的分成外，还将获得磨石金融提供的版权维权委托服务。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "新媒体合作联系 <br>xmt@patternfinance.com"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "技术联盟(TAP: Technology Alliance Partner)计划"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "今天就加入磨石金融TAP计划，你可以免费使用磨石金融提供的大部分数据API，并共享技术联盟计划内发布的网页组件和金融服务的源代码。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "TAP合作联系 <br>tap@patternfinance.com"
        }
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
            height: articleContentPanel.height

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
                        id: articleContentPanel
                        width: parent.width
                        height: {
                            var h = 0
                            for (var i = 1; i < contentLayout.children.length; i++) {
                                h += contentLayout.children[i].height
                            }

                            h += contentLayout.spacing * contentLayout.children.length

                            return h
                        }

                        Column {
                            id: contentLayout
                            anchors.fill: parent
                            spacing: 40

                            Repeater {
                                model: contentModel
                                delegate: Item {
                                    width: contentPanel.width
                                    height: {
                                        var h = 0
                                        if ("img" === type) {
                                            h = imgItem.height
                                        } else if ("txt" === type) {
                                            h = textItem.height
                                        } else if ("sectionHeader" === type) {
                                            h = textItem.height + 50
                                        }

                                        return h
                                    }

                                    Image {
                                        id: imgItem
                                        width: qmlWidth(contentPanel.width)
                                        height: width * ratio
                                        anchors.centerIn: parent
                                        source: "img" === type ? content : ""
                                        visible: "img" === type
                                    }

                                    Text {
                                        id: textItem
                                        width: qmlWidth(contentPanel.width)
                                        anchors.bottom: parent.bottom
                                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                        lineHeight: 30
                                        font.pixelSize: "sectionHeader" === type ? 30 : 18
                                        font.bold: "sectionHeader" === type ? true : false
                                        color: "sectionHeader" === type ? "#2a2a2a" : "#4a4a4a"
                                        text: content
                                        visible: "txt" === type || "sectionHeader" === type
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        LiveChat {
            id: liveChatPanel
            width: mainWindow.width
            anchors.horizontalCenter: parent.horizontalCenter
            userToken: "5/3ZwMh6PCqJ60EAuLrWZeo7Tvtng141r9wg86KVxosF90Z9cYiGVLiNniqGCupB7ZFOvB3iecnEkbY/9mvGv1Jkz+s3kIFsBzfffUUi/0E=" // moshikf_partners
        }
    }
}
