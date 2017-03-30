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
            content: "\n最后更新于 2017-03-30 17:03"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "STS是一个面向多策略开发的自动交易系统。支持包括策略开发、策略回测在内的多项功能。目前STS尚在概念设计和验证阶段。感谢您的关注。"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "STS交易系统开发理念"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<strong>一个典型的单策略交易系统</strong>"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "当你有一个经典策略和所需的数据时，你就可以开发出一个简单的单策略交易系统。而在你使用单策略交易时也许会经常遇到策略失效的情况，或者，当市场已经发生变化时我们通过单策略无法得知。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<strong>多策略交易系统的原罪</strong>"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "市场上已经存在着形形色色的多策略交易系统(比如<strong>策略轮动</strong>)，而它们如此设计的原因在于市场的不断变化(Regime-Switching)和单个交易策略的经常性失灵。但这并不意味着每一个多策略系统都能优于单策略系统。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<strong>TradingDesk的设计</strong>"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "我们用<strong>TradingDesk</strong>来抽象我们对交易市场的理解。每一个TradingDesk表示着一种对市场的理解，你也可以把它理解成一个现实世界中隐藏在交易台后的交易员。不同的TradingDesk会使用不同(或相似)的方法来交易，而设计的初衷在于交易系统的多样性。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "比如，我们可以使用STS中提供的<strong>LegacyDesk</strong>来构建一个基于简单均值回归或者动量策略的交易系统。或者，我们也可以通过<strong>QuantDesk</strong>来构建一个由双均线策略、海龟策略和动态突破策略组成的多策略交易系统。当我们有足够多的TradingDesk时，我们可以通过不同TradingDesk间的关联与变化来发现市场微观结构的改变。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: ""
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
            height: resourceBar.height + articleContentPanel.height

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
                        id: resourceBar
                        width: articlePanel.width * 0.9
                        height: 60
                        anchors.horizontalCenter: parent.horizontalCenter

                        Rectangle {
                            id: githubBtn
                            width: 100
                            height: 30
                            anchors.right: downloadBtn.left
                            anchors.rightMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
                            radius: 3
                            color: "#00a9e5"

                            Text {
                                width: 44
                                height: 17
                                anchors.centerIn: parent
                                font.pixelSize: 15
                                color: "white"
                                text: "Github"
                            }

                            GeneralMouseArea {
                                onClicked: {
                                    Qt.openUrlExternally("https://github.com/patternfinance/STS")
                                }
                            }
                        }

                        Rectangle {
                            id: downloadBtn
                            width: 100
                            height: 30
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            radius: 3
                            color: "#00a9e5"

                            Text {
                                width: 67
                                height: 17
                                anchors.centerIn: parent
                                font.pixelSize: 15
                                color: "white"
                                text: "Download"
                            }

                            GeneralMouseArea {
                                onClicked: {
                                    Qt.openUrlExternally("https://github.com/patternfinance/STS/archive/master.zip")
                                }
                            }
                        }
                    }

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
