import QtQuick 2.5

Rectangle {
    id: mainWindow

    Row {
        anchors.fill: parent

        Rectangle {
            id: reader
            width: Math.max(600, parent.width - sideBar.width)
            height: parent.height

            Rectangle {
                id: contentArea
                width: 800
                height: coverImg.height
                        + articleSummaryPanel.height
                        + articleContent.height
                border.width: 1
                border.color: "#efefef"
                anchors.top: parent.top
                anchors.topMargin: 25
                anchors.horizontalCenter: parent.horizontalCenter

                Column {
                    anchors.fill: parent

                    Image {
                        id: coverImg
                        width: parent.width
                        height: width / 2
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "http://ifanr-cdn.b0.upaiyun.com/wp-content/uploads/2017/01/economist-background.jpg"

                        Rectangle {
                            anchors.fill: parent
                            color: "black"
                            opacity: 0.6
                        }

                        Image {
                            id: piconImg
                            width: 20
                            height: 20
                            anchors.left: dashlineImg.left
                            anchors.bottom: dashlineImg.top
                            anchors.bottomMargin: 20
                            source: "../imgs/picon.png"
                        }

                        Text {
                            anchors.left: piconImg.right
                            anchors.leftMargin: 10
                            anchors.top: piconImg.top
                            anchors.topMargin: 4
                            font.pixelSize: 16
                            color: "white"
                            text: "Gimletech | 2017-01-15 08:23"
                        }

                        Text {
                            id: articleTitleText
                            width: 700
                            anchors.left: parent.left
                            anchors.leftMargin: 30
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 50
                            font.pixelSize: 30
                            lineHeight: 40
                            wrapMode: Text.WordWrap
                            color: "white"
                            text: "一周学会如何在股票交易中运用Mean-Reversion策略获利（第1篇）"
                        }

                        Image {
                            id: dashlineImg
                            width: parent.width - 60
                            anchors.left: parent.left
                            anchors.leftMargin: 30
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 150
                            fillMode: Image.TileHorizontally
                            source: "../imgs/dashLine_white.png"
                        }
                    }

                    Item {
                        id: articleSummaryPanel
                        width: parent.width
                        height: 300

                        Rectangle {
                            id: sPanel
                            width: 620
                            height: 150
                            anchors.top: parent.top
                            anchors.topMargin: 20
                            anchors.left: parent.left
                            anchors.leftMargin: 110
                            color: "#FAFAF9"

                            Text {
                                width: 580
                                anchors.centerIn: parent
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "导读：跟大家说一个好消息，AppSo 邀请谷歌开发者（微信号：Google_Developers）来到灵感早读栏目。今后你将会看到来自 Google 的应用设计分享，那些海外的观点和分析海量数据得出的结论，相信定能让你有所启发。"
                            }

                            Rectangle {
                                width: 4
                                height: parent.height
                                color: "#f2f2f2"
                            }
                        }

                        Text {
                            anchors.top: sPanel.bottom
                            anchors.topMargin: 10
                            anchors.left: sPanel.left
                            font.pixelSize: 16
                            font.weight: Font.Light
                            color: "#4a4a4a"
                            text: "文章字数：1288"
                        }

                        Text {
                            anchors.top: sPanel.bottom
                            anchors.topMargin: 37
                            anchors.left: sPanel.left
                            font.pixelSize: 16
                            font.weight: Font.Light
                            color: "#4a4a4a"
                            text: "阅读时长：3 min"
                        }
                    }

                    Item {
                        id: articleContent
                        width: parent.width
                        height: 3000

                        Column {
                            anchors.fill: parent
                            spacing: 40

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "在具体研究Mean-Reversion策略之前，我们先来谈谈我们到底在分析什么。我们知道，股市中最常见的莫过于股票的走势了。我们常常通过解读一只股票的历史报价来分析它当前的状态，以及预测它未来可能的走势。而这一切的基础就是股票报价的时间序列 - 价格序列(Price Series)。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "一、价格序列你所需要知道的那些事"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "关于Price Series，你需要先了解一些概念和一些在实践中需要注意的东西:"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "1）Price Series是一个在时间维度T上连续的序列，我们之后的所有分析都是基于这一连续序列。这里有需要注意的一点是：在实际交易中，股票的Price Series经常会在时间上跨越周末和节假日，但它仍是连续的(我们可以把T理解成一个个连续的交易日)。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "2）我们可以将股票价格序列分成Mean-Reverting、Trending和Random Walk(随机游走)这3类来进行进一步分析。随机游走是其中最好理解的一种，即股票下一时间(根据所选时间维度的不同可以理解成下一秒、下一分钟、下一小时、下一个交易日等等)的价格走势是随机的。我们也经常用toss coin来形容这种走势下预测准确的概率。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "3）股票的走势并不会只是一种类型，比如：过去一年股票A呈现Mean-Reverting的状态，但未来一段时间它可能是随机游走的，也可能是Trending的。这里需要注意的是，状态之间的转化在某些事件下(比如重大的信息披露、金融危机爆发等等)可能是瞬时发生的。比如我们在确定股票A的走势呈Mean-Reverting状态后，在其股价低于均价(mean)时买进，并计划在其价格回到(甚至超过)mean时卖出。但是期间有重大的负面信息被披露，股价从reverting变成急转直下(Trending)。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "4）在量化交易和程序化交易中，最常使用的价格序列是以每日收盘价(close price)组成的时间序列。除此之外，我们还大量使用一些价格的衍生和变形(price derivatives and transformations)，以及一些技术指标。比如：Log return、移动平均线(SMA)以及DPO(Detrended Price Oscillator)、Absolute ATR(Average True Range)、RSI和市场均值回归指数(Market Meanness Index)。我们通常将这些量称之为feature，用技术方法小心筛选后(feature selection)作为机器学习算法的输入。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "二、均值回归的特点有哪些？"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "我们很容易想象均值回归是如何运用于股票交易的："
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "（版本1）在股票价格低于平均价格时买入。持有一段时间，当价格回到平均价格或在平均价格之上时卖出。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "版本1描述了均值回归策略的一般思路，即买在均值下，卖在均值上。但在实际交易中我们还需要知道更多的信息，比如：一只股票的平均价格是多少？低于平均价格多少的时候买入，又在什么时候卖出？买入后大概需要持有多长时间？在股票A上运用一次该策略我能获利多少？"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "我们来看看版本2是如何回答上面的问题的。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "（版本2）在股票价格低于200日均价2%时买入。根据我们对之前该股票价格序列的分析，大概持有60天，当价格回到平均价格或在平均价格2%之上时卖出。如果策略正常运行，那么将有2%-4%的收益(未含手续费，也不考虑slippage等费用)。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "好了，相较于版本1，版本2给出了一个更具有指导性的交易策略。我们把这些重要信息逐条列出来："
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "1）Mean：股票价格序列的均值，即上述例子中的200日均价"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "2）"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "3）H: 均值回归的速度，即上述例子中的60天持有期。在Mean-Reversion中我们使用物理学中的半衰期(Half-Life)来表示这一速度"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "在逐一解读这些信息前，我们先回到Mean-Reversion本身来看下它们是如何被定义的。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "首先，让我们来看看到底什么是Mean-Reversion。这里我们引用大家都能找到的，对均值回归过程解释的[ Wikipedia ]：In mathematics, the Ornstein–Uhlenbeck process, is a stochastic process that, roughly speaking, describes the velocity of a massive Brownian particle under the influence of friction. The process is stationary Gauss–Markov process (which means that it is both a Gaussian and Markovian process), and is the only nontrivial process that satisfies these three conditions, up to allowing linear transformations of the space and time variables. Over time, the process tends to drift towards its long-term mean: such a process is called mean-reverting. "
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "翻译和解读如下："
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "1）Mean-Reversion是随机过程的一种，学术名叫做Ornstein-Uhlenbeck过程。需要注意的是，既然它是随机过程的一种，那么我们就需要一种方法来判定某只股票的价格序列是否满足这一过程的描述。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "2）这种过程是Stationary、Gaussian和Markovian的(过程)。也就是说，在我们希望采用Mean-Reversion策略之前，我们先要检验我们所给定的股票价格序列是否满足这3个条件。所谓Stationary过程，放在均值回归中解释就是：价格序列的均值mean和方差variance保持不变。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "3）当前取值越是偏离均值(套用版本2中的例子，即当前价格与200日均值的差值绝对值越大)，其后回归到均值的可能性越大。我们可以以此为依据决定什么时候买入或卖出。"
                            }
                        }
                    }
                }

                Rectangle {
                    id: shareBar
                    width: 80
                    height: 265
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    y: coverImg.height + sPanel.anchors.topMargin

                    Text {
                        id: sharesCountText
                        anchors.left: parent.left
                        font.pixelSize: 20
                        font.bold: true
                        color: "#4a4a4a"
                        text: "22"
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

                                    MouseArea {
                                        anchors.fill: parent
                                        onEntered: {
                                            sbImg.source = "../imgs/" + sns + "c.png"
                                        }
                                        onExited: {
                                            sbImg.source = "../imgs/" + sns + ".png"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            id: sideBar
            width: 400
            height: parent.height

            Text {
                id: jcText
                anchors.top: parent.top
                anchors.topMargin: 25
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 30
                font.family: "Krugthep"
                color: "#5B7FA2"
                text: "韭菜投资"
            }

            Text {
                anchors.top: parent.top
                anchors.topMargin: 65
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 10
                color: "#9b9b9b"
                text: "如何在股市中持续获利"
            }

            Rectangle {
                width: 2
                height: parent.height
                anchors.top: parent.top
                anchors.left: parent.left
                color: "#efefef"
            }

            Rectangle {
                id: profilePanel
                width: 300
                height: 140
                anchors.top: parent.top
                anchors.topMargin: 100
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1
                border.color: "#efefef"
                radius: 2

                Rectangle {
                    id: imgItem
                    width: 70
                    height: 70
                    anchors.top: parent.top
                    anchors.topMargin: 1
                    anchors.left: parent.left
                    anchors.leftMargin: 1

                    Image {
                        width: 50
                        height: 50
                        anchors.centerIn: parent
                        source: "../imgs/preloader.gif"
                    }
                }

                Text {
                    anchors.top: imgItem.top
                    anchors.topMargin: 10
                    anchors.left: imgItem.right
                    anchors.leftMargin: 5
                    font.pixelSize: 18
                    color: "#4a4a4a"
                    text: "Gimletech"
                }

                Text {
                    anchors.top: imgItem.top
                    anchors.topMargin: 40
                    anchors.left: imgItem.right
                    anchors.leftMargin: 5
                    font.pixelSize: 14
                    color: "#4a4a4a"
                    text: "用量化分析和可视化数据解读投资"
                }

                Text {
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 37
                    anchors.horizontalCenter: wzzsText.horizontalCenter
                    font.pixelSize: 18
                    color: "#4a4a4a"
                    text: "160"
                }

                Text {
                    id: wzzsText
                    anchors.left: parent.left
                    anchors.leftMargin: 7
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    font.pixelSize: 14
                    color: "#4a4a4a"
                    text: "文章总数"
                }
            }

            Rectangle {
                id: recommArticlePanel
                width: 300
                height: 160
                anchors.top: parent.top
                anchors.topMargin: 280
                anchors.horizontalCenter: parent.horizontalCenter

                Column {
                    anchors.fill: parent

                    Item {
                        id: recommTitleBar
                        width: parent.width
                        height: 30

                        Text {
                            font.pixelSize: 16
                            color: "#4a4a4a"
                            text: "推荐阅读"
                        }

                        Rectangle {
                            width: parent.width
                            height: 3
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "#5B7FA2"
                        }
                    }

                    Item {
                        id: aSpacer
                        width: parent.width
                        height: 21
                    }

                    Item {
                        id: aListItem
                        width: parent.width
                        height: parent.height
                                - recommTitleBar.height
                                - aSpacer.height

                        Column {
                            anchors.fill: parent
                            spacing: 10

                            Repeater {
                                model: ListModel {
                                    ListElement {
                                        aTitle: "怎样确定投资机会？"
                                    }
                                    ListElement {
                                        aTitle: "实时监控系统性风险"
                                    }
                                    ListElement {
                                        aTitle: "均值回归策略都可以怎么用？"
                                    }
                                }
                                delegate: Item {
                                    width: recommArticlePanel.width
                                    height: 30

                                    Image {
                                        width: 30
                                        height: 30
                                        anchors.left: parent.left
                                        anchors.verticalCenter: parent.verticalCenter
                                        source: "../imgs/n" + (index+1) + ".png"
                                    }

                                    Text {
                                        anchors.top: parent.top
                                        anchors.topMargin: 5
                                        anchors.left: parent.left
                                        anchors.leftMargin: 40
                                        font.pixelSize: 16
                                        color: "#4a4a4a"
                                        text: aTitle
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Rectangle {
                id: recommBookPanel
                width: 300
                height: 600
                anchors.top: recommArticlePanel.bottom
                anchors.topMargin: 45
                anchors.horizontalCenter: parent.horizontalCenter

                Column {
                    anchors.fill: parent

                    Item {
                        id: rBookTitleBar
                        width: parent.width
                        height: 30

                        Text {
                            font.pixelSize: 16
                            color: "#4a4a4a"
                            text: "精选书籍"
                        }

                        Rectangle {
                            width: parent.width
                            height: 3
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "#5B7FA2"
                        }
                    }

                    Item {
                        id: bSpacer
                        width: parent.width
                        height: 30
                    }

                    Image {
                        id: bookCoverImg
                        width: 350
                        height: 350
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "../imgs/books/gpzshyl.jpg"
                    }

                    Item {
                        id: spacer0
                        width: parent.width
                        height: 20
                    }

                    Item {
                        id: jdzyEntry
                        width: parent.width
                        height: 65

                        Image {
                            width: 67
                            height: 30
                            anchors.horizontalCenter: parent.horizontalCenter
                            source: "../imgs/jdzy.png"
                        }

                        Rectangle {
                            width: 100
                            height: 30
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            radius: 3
                            color: "#F25352"

                            Text {
                                anchors.top: parent.top
                                anchors.topMargin: 4
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.pixelSize: 16
                                color: "white"
                                text: "直达链接"
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                            }
                        }
                    }
                }
            }
        }
    }
}
