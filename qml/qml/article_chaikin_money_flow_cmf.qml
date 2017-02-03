import QtQuick 2.5
import "./Sidebar.qml"

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
                            text: "Gimletech | 2017-01-20 19:45"
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
                            text: "股票成交量分析(篇1)：Chaikin Money Flow指标"
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
                                text: "导读：菜金资金流量(Chaikin Money Flow)指标可以被用于成交量的分析，而成交量对于股票交易来说也有着不可或缺的意义。CMF的振荡范围在-1和+1之间，你可以很直观地从中看出多空势力是如何变化的。CMF既被运用于量化投资中，也常常被喜欢图表分析的投资者使用。"
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
                        height: 4000

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
                                text: "一、给我一个CMF的例子"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "好吧，我们将用下面的例子来讲解CMF到底有什么用，以及我们可以通过CMF得到哪些我们关心的信息。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "图一展示的是东阿阿胶(SZ000423)2016年全年的股票走势以及对应的20日CMF。20日CMF是常用的设置，在实际交易中你也可以根据你自己的研究选择其他的取值，比如10日CMF或者15日CMF。在图1中，我觉得至少有这几样东西值得关注："
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "1）CMF当前的取值，是大于0，还是小于0。大于0表示当前多方势力占主导，即有更多的买单。而小于0则相反。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "2）CMF过去一段时间的取值。有没有(或者当前是不是正在)crossover, 或者有没有明显的峰顶或谷底。这些都是很明显的Regime Switch。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "3）过去一段时间股票的走势。有没有明显的趋势，有没有振荡。这些很显然和判定是否存在投资机会有关。"
                            }

                            Item {
                                width: 620
                                height: 395
                                anchors.left: parent.left
                                anchors.leftMargin: 110

                                Rectangle {
                                    id: fig1
                                    width: 620
                                    height: 347
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    color: "#d8d8d8"

                                    Image {
                                        anchors.fill: parent
                                        source: "../articledata/cmf_1.png"
                                    }
                                }

                                Text {
                                    width: 380
                                    anchors.bottom: parent.bottom
                                    anchors.horizontalCenter: fig1.horizontalCenter
                                    wrapMode: Text.WordWrap
                                    font.pixelSize: 16
                                    color: "#4a4a4a"
                                    text: "图1 - 东阿阿胶2016年走势以及CMF走势。支撑线和阻力线采用Volume-by-Price方式生成。"
                                }

                                Text {
                                    anchors.right: fig1.right
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 10
                                    font.pixelSize: 16
                                    color: "#5B7FA2"
                                    text: "<开始测试>"

                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                        }
                                    }
                                }
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "怎么样，有没有觉得CMF很容易掌握？在我们进一步讨论CMF之前，你可以点击图1图例右下角的<开始测试>来试一试你是否能很好运用CMF。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "二、CMF的特点"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "所有的技术指标都有一个相同的特点：它们时而有用，时而无用。而不幸的是，它们通常会在你想要使用它们时变得无用。很显然，即便你准确掌握了CMF指标的用法也无法100%能保证你可以从交易中获利。那么我们还讨论什么？如同大多数技术指标，CMF的第一大特点是它不应该被单独使用。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "无论这个和CMF一起使用的其他指标是1个还是100个，保证CMF能够有效的前提是你的交易系统是否有效。这不是一句正确的废话，在我看来，它至少包含这么几层意思。首先，你要有一个交易系统，无论这个系统是否是程序化的，你得反复验证。而反复验证的目的除了发现并纠正错误外，更重要的一点是你如何通过一次次犯错来提高你改正错误的方式和速度。正如“天下武功唯快不破”所讲的那样，决胜的关键是你是否可以用更少的时间踩完别人所有踩过的坑。其次，除了CMF外你还需要掌握更多的东西，无论是技术指标、神奇指数或者别的一些什么。但更要学会筛选。简单来说就是：韩信用兵多多益善(足够的信息，比如100种指标)和奥卡姆剃刀(找到解决问题最直接的方式，比如100种指标里面只有10种是对你交易某只股票有用的)。你也可以记住这两个英文单词：Sufficient and Simple。然后，即便在确定CMF已经能够帮助你交易某只股票后也不要忘记，还有很多事能让它瞬间不起作用。比如，恐慌抛售。CMF并没有办法抵御黑天鹅。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "CMF的取值范围在-1到+1之间(通常在-0.5和+0.5之间振荡)。如果我们测试2014-2016年间沪深300指数所包含所有300支股票的20日CMF取值范围。我们会得到如下结果(图2)。很符合取值大多在-0.5和+0.5之间的预期。"
                            }

                            Item {
                                width: 620
                                height: 330
                                anchors.left: parent.left
                                anchors.leftMargin: 110

                                Rectangle {
                                    id: fig2
                                    width: 620
                                    height: 310
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    color: "#d8d8d8"

                                    Image {
                                        width: parent.width
                                        height: parent.height
                                        anchors.centerIn: parent
                                        source: "../articledata/hs300_cmf.png"
                                    }
                                }

                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.horizontalCenter: fig2.horizontalCenter
                                    font.pixelSize: 16
                                    color: "#4a4a4a"
                                    text: "图2 - 2014-2016沪深300指数300支股票CMF取值分布"
                                }
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "一支股票的CMF取值在零线上下振荡，有时在很短的一段时间内可能会多次穿越零线(比如多空势力胶着时)。过多的穿越信号可能会影响我们对当前多空势力强弱的判断，这时我们可以通过设定threshold来过滤掉不必要的信号。比如，我们可以把crossover信号设定在±0.05上。当CMF(穿过零线并且)大于+0.05时我们认定这时多方势力占主导，当CMF(穿过零线并且)小于-0.05时则相反。Threshold的选定可以根据经验也可以根据你交易策略回测的结果来调整。下图(图3)是一个使用threshold来避免过多零线穿越信号的例子，适用于包含很多微小锯齿的CMF形态。设定threshold后触发信号由15个降至3个。"
                            }

                            Item {
                                width: 620
                                height: 530
                                anchors.left: parent.left
                                anchors.leftMargin: 110

                                Rectangle {
                                    id: fig3
                                    width: 620
                                    height: 507
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    color: "#d8d8d8"

                                    Image {
                                        anchors.fill: parent
                                        source: "../articledata/cmf_2.png"
                                    }
                                }

                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.horizontalCenter: fig1.horizontalCenter
                                    font.pixelSize: 16
                                    color: "#4a4a4a"
                                    text: "图3 - 通过设定threshold来避免过多零线穿越。来源: stockcharts.com"
                                }
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "三、如何计算CMF"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "计算CMF的方法很简单，分为三步。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "第一步：计算每日Money Flow Multiplier(MF Multiplier)"
                            }

                            Image {
                                width: 468
                                height: 43
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                source: "../articledata/cmf_f1.png"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "第二步：计算每日Money Flow Volume(MF Volume)"
                            }

                            Image {
                                width: 442
                                height: 17
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                source: "../articledata/cmf_f2.png"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "第三步：计算每日的CMF(在本篇中计算每日的20日CMF)"
                            }

                            Image {
                                width: 393
                                height: 41
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                source: "../articledata/cmf_f3.png"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "如果你使用Pandas Dataframe来储存这些数据(比如使用TuShare或者Data Reader获取到的股票数据), 那么你可以使用div、multiply、rolling_sum这些Dataframe的函数来完成CMF的计算。图4是一个简单的计算示例。"
                            }

                            Item {
                                width: 620
                                height: 720
                                anchors.left: parent.left
                                anchors.leftMargin: 110

                                Rectangle {
                                    id: fig4
                                    width: 620
                                    height: 706
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    color: "#d8d8d8"

                                    Image {
                                        anchors.fill: parent
                                        source: "../articledata/cmf_3.png"
                                    }
                                }

                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.horizontalCenter: fig1.horizontalCenter
                                    font.pixelSize: 16
                                    color: "#4a4a4a"
                                    text: "图4 - Research in Motion(股票代码: RIMM) 20日CMF计算示例。来源: stockcharts.com"
                                }
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "四、失效的Chaikin Money Flow"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "CMF可能会失效，正如它可能并不适用于所有股票一样，意外总会发生。在每日Money Flow Multiplier的计算中隐藏着一颗地雷。让我们来简单回顾一下MF Multiplier的计算方式，它只使用了当天的报价数据。这有什么问题呢？如果你也使用Average True Range指标，你会发现MF Multiplier的计算结果与前一天的报价完全无关。让我们先来看一幅图(图5)。"
                            }

                            Item {
                                width: 620
                                height: 270
                                anchors.left: parent.left
                                anchors.leftMargin: 110

                                Rectangle {
                                    id: fig5
                                    width: 620
                                    height: 248
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    Image {
                                        anchors.fill: parent
                                        source: "../articledata/cmf_4.png"
                                    }
                                }

                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.horizontalCenter: fig1.horizontalCenter
                                    font.pixelSize: 16
                                    color: "#4a4a4a"
                                    text: "图5 - MF Multiplier的正负只与当天报价有关"
                                }
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "当MF Multiplier的正负只由当天报价所决定时，当天的CMF取值也只由当天的最高价、最低价和收盘价决定。在大多数时候，由于我们计算的是N-day CMF，即所选定时间范围(比如20日CMF)的移动平均值，所以当每日成交量(无论是买入还是卖出)差别不大时，最后的计算结果可以准确的反映多空势力的变化。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "CMF的失效发生在成交量急剧变化时(Volume Spikes)。需要注意，并不是每次Volume Spike时CMF都会失效。失效的本质在于当天的报价范围。当成交量急剧增加(无论是买入还是卖出)并且当当日的收盘价偏离中间价越多时，CMF失效的可能性越大。"
                            }

                            Item {
                                width: 620
                                height: 660
                                anchors.left: parent.left
                                anchors.leftMargin: 110

                                Rectangle {
                                    id: fig6
                                    width: 620
                                    height: 639
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    Image {
                                        anchors.fill: parent
                                        source: "../articledata/cmf_sx1.png"
                                    }
                                }

                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.horizontalCenter: fig1.horizontalCenter
                                    font.pixelSize: 16
                                    color: "#4a4a4a"
                                    text: "图6 - CMF在暴跌后失效。来源: stockcharts.com"
                                }
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "上图(图6)展示了CMF在暴跌后失效的原因。首先，当日成交量远远高于过去一段时间的平均成交量。其次，当天的收盘价造成了较大的MF Multiplier，使得最后的CMF为正值，且远大于之前的20日CMF移动平均。最后的结果是，明明当日是暴跌，当日的20日CMF取值却表现出多方势力(占主导)的增强。需要再次强调的是，成交量在这里只是诱因。想象我们使用相同的成交量，如果且当日收盘价更接近当日最低价，那么我们将会得到一个完全不同的结果。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "这种糟糕的情况也同样有可能发生在价格上涨时。当价格上涨，成交量剧增，但收盘价更接进去当日最低价时，CMF会录得较大的负值，从而使得20日CMF也为负(图7)。"
                            }

                            Item {
                                width: 620
                                height: 660
                                anchors.left: parent.left
                                anchors.leftMargin: 110

                                Rectangle {
                                    id: fig7
                                    width: 620
                                    height: 639
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    Image {
                                        anchors.fill: parent
                                        source: "../articledata/cmf_sx2.png"
                                    }
                                }

                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.horizontalCenter: fig1.horizontalCenter
                                    font.pixelSize: 16
                                    color: "#4a4a4a"
                                    text: "图7 - CMF在股价上涨时显示空方势力增强。来源: stockcharts.com"
                                }
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "那么，我们该如何处理这些失效情况呢？"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "首先，不要忘记使用CMF需要了解的第一点：不要单独使用它。当我们将CMF放在我们自己的交易逻辑里一起思考时，我们至少有两种办法来应对失效。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "1) 将前一日收盘价加入计算。如果当日股票收盘价低于前一日收盘价，那么当日CMF应为负值。反之当日CMF应为正值。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "2) 忽略掉失效的CMF，以前一日CMF代替。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "这两种方法各有利弊。最终取决于你打算如何使用CMF。如果我们将CMF的取值作为交易信号(比如大于+0.05时，我们考虑买入)，那么失效将可能直接让我们向错误的方向操作。如果我们将CMF用作趋势的确定，那么当我们的交易时间跨度足够长(比如我们考虑200日趋势)，我们则有理由剔除掉这些异常的点。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: 110
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: ""
                            }
                        }
                    }
                }

                Sharebar {
                    id: shareBar
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    y: coverImg.height + sPanel.anchors.topMargin
                }
            }
        }

        Sidebar {
            id: sideBar
            width: 400
            height: parent.height
        }
    }
}
