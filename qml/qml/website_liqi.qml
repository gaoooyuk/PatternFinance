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
            content: "\n利器版本: 2017-03-17 16:09"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "财经数据"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<strong>TuShare</strong>  一个免费、开源的python财经数据接口包。主要实现对股票等金融数据从数据采集、清洗加工到数据存储的过程，能够为金融分析人员提供快速、整洁、和多样的便于分析的数据，为他们在数据获取方面极大地减轻工作量，使他们更加专注于策略和模型的研究与实现上。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "官网: http://tushare.org/"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "Github: https://github.com/waditu/tushare (Python)"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "技术分析(技术指标/技术图形/时间序列)"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<strong>TA-Lib</strong>  提供200种技术分析指标和蜡烛图模式识别API。包括MACD、RSI、Bollinger Bands、十字星线、蜻蜓星等在实战中使用频率较高的指标和图形。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "官网: http://ta-lib.org/"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "Github: https://github.com/mrjbq7/ta-lib (Python)"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<strong>ARCH</strong>  使用ARCH相关模型对时间序列进行分析。提供Volatility Modeling、Unit Root Tests(ADF/KPSS/Phillips-Perron)和Bootstrap等API。Github地址: https://github.com/bashtage/arch"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<strong>statsmodels</strong>  功能强大的统计建模和计量经济学工具包。Github地址: https://github.com/statsmodels/statsmodels"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "交易系统 - 回测"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<strong>Zipline</strong> (Python)  Quantopian背后的回测引擎。Github地址: https://github.com/quantopian/zipline"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<strong>RQAlpha</strong> (Python)  由Ricequant米筐科技开源的回测引擎。Github地址: https://github.com/ricequant/rqalpha"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "交易系统 - 交易API"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "在这里我们收录了一些LTS(由券商提供的自由交易系统)和CTP(统一行情交易接口)提供商和API。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<strong>华宝证券 LTS</strong>"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "交易系统 - 杂项"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "Watchlist"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "我们在这里收录了一些暂未分类的产品和它们背后的(金融)科技公司。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<strong>Prophet</strong> (Python/R/Time Series)  出自于Facebook的Core Data Science团队。Prophet适用于大规模的时间序列预测。Github地址: https://github.com/facebookincubator/prophet"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<strong>pyfora</strong> (Python/分布式计算)  由一家名叫Ufora的公司开发。主要应用于对数据分析、量化建模和其他一些任务的分布式计算。Github地址: https://github.com/ufora/ufora"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: ""
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
