import QtQuick 2.5
import "./Sidebar.qml"
import "./Sharebar.qml"

Rectangle {
    id: mainWindow

    Row {
        anchors.fill: parent

        Rectangle {
            id: reader

            property int lMargin: 110

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
                        source: "http://images2.fanpop.com/image/photos/13900000/Dragon-Wallpaper-dragons-13975578-1280-800.jpg"

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
                            text: "阿一西德卤 | 2017-01-26 11:15"
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
                            text: "市场错估重现江湖，屠龙英雄莫问出处"
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
                            height: 140
                            anchors.top: parent.top
                            anchors.topMargin: 20
                            anchors.left: parent.left
                            anchors.leftMargin: reader.lMargin
                            color: "#FAFAF9"

                            Text {
                                width: 580
                                anchors.centerIn: parent
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "导读：如果你是有效市场假说(Efficient Market Hypothesis)的拥护者，那么你一定会争论市场错估(Market Anomaly)是否会真正出现。而如果你反对EMH中所描述的市场是有效的，那么市场错估将成为你反击有效市场假说的最有力武器。"
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
                                anchors.leftMargin: reader.lMargin
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "这是一场有效市场假说和市场错估的对决。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: reader.lMargin
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "一、从来都没有真正的错与对"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: reader.lMargin
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "市场有效假说成说于19世纪70年代，由芝加哥大学的金融教授Eugene Fama提出。在EMH中，Fama教授提出了三种有效程度不同的市场(分别为弱式、半强式和强式)。而在最有效的强效市场中，证券的价格反映了所有公开和不公开的信息。这也是EMH中最为人所知的 — Price is right。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: reader.lMargin
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "股票价格在这种情况下永远都不会被高估或低估。每当一有新的信息出现，股票的价格都将会随之准确地被修正。股票的价格在最有效的市场中也代表了股票背后的实际价值。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: reader.lMargin
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "在完全有效的市场中，任何想要通过价格波动来盈利的行为似乎都是无用的。当股票不包含任何对未来的预期时，人们也不会那么对股票趋之若鹜了。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: reader.lMargin
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "那么在不那么有效的市场中呢？"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: reader.lMargin
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "不同于完全有效市场对信息处理的超级高效，弱式有效市场资产价格反映历史信息而半强式有效市场反应公开市场信息。在信息不透明或信息滞后的影响下，股票价格并不能准确反映资产价值，至少，不能及时反映。而这时，如果你拥有最及时的信息来源和最快的交易速度，那么你将有机会在股票价格被修正前套利。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: reader.lMargin
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "有这么一个关于有效市场假说和经济学家的故事。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: reader.lMargin
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "一个经济学家和他的学生走在校园里的路上。忽然学生看到地上散落着一些钱，他马上提醒老师：教授先生，地上有钱。教授淡定地说到：It's impossible, 即使有散落在地上的钱，也会马上被人拣走的！"
                            }

                            Rectangle {
                                width: 620
                                height: 347
                                anchors.left: parent.left
                                anchors.leftMargin: reader.lMargin
                                color: "#d8d8d8"

                                Image {
                                    anchors.fill: parent
                                    source: "../articledata/stock_market_anomalies/dollarontheground.png"
                                }
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: reader.lMargin
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "这是有效市场假说流传得最广的一个笑话。如果我们以严肃的态度来解读它的话，我们会发现一些有意思的东西:"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: reader.lMargin
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "1. EMH并不是说市场一直都是有效并且高效的。而非有效的市场会滋生市场错估。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: reader.lMargin
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "2. 谁先一步发现市场错估(Market Anomaly), 谁就越有机会(捡到掉在地上的钱)。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: reader.lMargin
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "3. 除了眼尖(越早获得信息，发现别人没发现的信息)，你还得手快。这也是高频交易(HFT)所依赖的。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: reader.lMargin
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "当人们纠结于市场是否是有效的时，我们却常常选择性地忽略了有效市场假说的另外一点: No free lunch。天上掉馅饼的机会寥寥无几，而超额收益也并不是那么容易获取。"
                            }

                            Rectangle {
                                width: 620
                                height: 333
                                anchors.left: parent.left
                                anchors.leftMargin: reader.lMargin
                                color: "#d8d8d8"

                                Image {
                                    width: 620
                                    height: 333
                                    anchors.centerIn: parent
                                    source: "../articledata/stock_market_anomalies/freelunch.jpg"
                                }
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: reader.lMargin
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "你一定有过售票窗口前排队的经历吧。如果我们把选窗口和选股票放在一起比较的话，你就会发现no free lunch很好被理解。想象你走进了一间人头攒动的售票大厅。大厅里有很多个售票窗口，每个窗口外都排满了形形色色的人。你也许会选择离你最近的一个窗口排队，无论队列里的人是多还是少。也许你会选择先观察一下，看看哪个窗口前排着最少的人再做决定，无论这个窗口离你是近还是远。当然你还可以有更多种选择。但你真的能做出最好的决定吗？假设你已经找到了一条到售票窗口前最近的队列，但谁能保证当你站进队列后这个窗口不会因为意外而暂时关闭(比如售票阿姨突然想上厕所)。"
                            }

                            Rectangle {
                                width: 620
                                height: 393
                                anchors.left: parent.left
                                anchors.leftMargin: reader.lMargin
                                color: "#d8d8d8"

                                Image {
                                    width: 620
                                    height: 393
                                    anchors.centerIn: parent
                                    source: "http://a0.att.hudong.com/03/79/06300000046969119971797347435.jpg"
                                }
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: reader.lMargin
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "投资经理也许花了太多的时间去选择最好的策略以至于他们的业绩往往跑不赢大盘。而即便是对市场有着深入研究的投资大拿也不一定能跑赢民间高手。这对于EMH来说的意义在于，即便你能发现并把握住了每一个市场错估，你也还是需要一种随遇而安的心态。你可能躺赢也同样可能躺着中枪。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: reader.lMargin
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "你相信你所相信的。"
                            }

                            Text {
                                width: 620
                                anchors.left: parent.left
                                anchors.leftMargin: reader.lMargin
                                wrapMode: Text.WordWrap
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "二、股市中可能存在的市场错估(Market Anomalies)"
                            }

                            Rectangle {
                                width: 620
                                height: 327
                                anchors.left: parent.left
                                anchors.leftMargin: reader.lMargin
                                color: "#d8d8d8"

                                Image {
                                    width: 620
                                    height: 327
                                    anchors.centerIn: parent
                                    source: "../articledata/stock_market_anomalies/alpha.png"
                                }
                            }

                            Rectangle {
                                width: 620
                                height: 200
                                anchors.left: parent.left
                                anchors.leftMargin: reader.lMargin
                                color: "#d8d8d8"

                                Image {
                                    width: 620
                                    height: 200
                                    anchors.centerIn: parent
                                    source: "../articledata/stock_market_anomalies/anomalies.png"
                                }
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
