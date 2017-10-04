import QtQuick 2.5

Rectangle {
    id: mainWindow

    property string coverImage: "../imgs/about/cover.png"

    function qmlWidth(w) {
        return w + 1
    }

    function qmlHeight(h) {
        return h + 1
    }

    height: snsBar.height
            + coverPanel.height
            + articlePanel.height

    ListModel {
        id: contentModel
        ListElement {
            type: "txt"
            ratio: 1
            content: "\n磨石金融Mindstore让你听见全世界关于投资这件事最权威的声音"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "Man Group英仕曼集团"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "英仕曼集团在全球范围内管理着超过950亿美元的资产，也是在中国境内首个获得中国私募证券投资基金管理人牌照的海外对冲基金。英仕曼集团旗下目前管理着五支对冲基金，其中包括了最负盛名的Man AHL对冲基金。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<a href=https://www.ahl.com/machine-learning target=_blank>Sep 2017 - Machine learning in investment management</a>"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<a href=https://www.ahl.com/the-rise-of-machine-learning target=_blank>Aug 2016 - The Rise of Machine Learning at Man AHL</a>"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: ""
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "Bridgewater桥水"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "桥水在全球范围内管理着1600亿美元的资产，其客户中不乏公共养老基金、大学捐赠基金、主权财富基金和中央银行的身影。桥水基金不仅是一家拥有超高赚钱效率的对冲基金，还为投资圈贡献了一种价值非凡的投资理念：All Weather Strategy全天候交易策略。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<a href=https://www.bridgewater.com/resources/all-weather-story.pdf target=_blank>The All Weather Story</a>"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<a href=https://www.bridgewater.com/resources/risk-parity-is-about-balance.pdf target=_blank>Risk Parity is About Balance</a>"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "AQR"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "作为对冲基金界大佬的AQR有着一个类似图书馆的论文期刊系统。在他们的官网上有一大堆高质量的原创研究论文提供给大家下载。AQR在全球范围内管理着1950亿美元的资产，其投资方式在涵盖了包括Smart Beta、风险平价（Risk Parity）、全球宏观和事件驱动在内的多种策略。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<a href=https://www.aqr.com/-/media/files/papers/market-timing-sin-a-little.pdf target=_blank>Aug 2017 - Market Timing: Sin a Little</a>"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<a href=https://www.aqr.com/-/media/files/papers/jai_summer_2017_aqr.pdf target=_blank>July 2017 - Measuring Factor Exposures: Uses and Abuses</a>"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<a href=http://www.iinews.com/site/pdfs/JPM_SE_2017_AQR.pdf target=_blank>Mar 2017 - Contrarian Factor Timing is Deceptively Difficult</a>"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<a href=http://www.iinews.com/site/pdfs/JAI_Winter_2017_AQR.pdf target=_blank>Jan 2017 - Embracing Downside Risk</a>"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<a href=http://www.sciencedirect.com/science/article/pii/S0304405X16301490 target=_blank>Sep 2016 - Momentum Crashes</a>"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<a href=https://www.aqr.com/-/media/files/perspectives/joim-investing-with-style.pdf target=_blank>Jan 2015 - Investing With Style</a>"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<a href=https://www.aqr.com/-/media/files/papers/understanding-style-premia.pdf target=_blank>Dec 2014 - Understanding Style Premia</a>"
        }
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
    }
}
