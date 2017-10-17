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
            content: "\n这是一本以小说方式呈现的股市投资指南。主人翁柯宇的故事将以第一人称展现。而其他角色(陈妍柔、林仲礼)的经历将以POV第三人称方式叙述。"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "POV: 陈妍柔"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "突然有点小感冒但是还算过得去，陈妍柔给自己倒了一杯热水，然后懒洋洋地靠在沙发垫上开始发呆。23岁，刚入职场，大大咧咧，长相一般，这是大多数认识她的人对她的第一印象。不过陈妍柔觉得自己这样挺好的，简简单单。感冒和发呆也许并不能算得上是绝配，但总算可以找个借口过个周末了。陈妍柔这样想着，脑子里却无法控制地有K线图闪过。“打住！打住！今天是星期六”陈妍柔轻轻地拍了拍自己的脑袋。因为感冒的缘故头还有点晕眩，陈妍柔对连周末还记挂着股市的自己有点无奈，有点讨厌。昨天大盘的表现并不怎么样。虽然没有上蹿下跳地再次饰演猴戏，但偷偷在手机上盯了一上午盘的陈妍柔并没有因为自己的虔诚而受到股神的眷顾，几个月前买的青岛海尔(600690)高开低走，最终在那个波澜不惊的下午怒跌1分钱。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "陈妍柔并不是一个初入股市的新手，甚至于可以说对于股票还算颇有心得。虽然刚入职场不久，但炒股那可是从大二就开始坚持的事。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "和许多刚进入大学校园的新生一样，陈妍柔一边在新学期课业和社团活动中忙的不可开交，一边憧憬着酒不醉人人自醉般的甜蜜爱情和四年寒窗苦读后的伟大前程。陈妍柔是个有自己打算的人，她也知道在享受恋爱和青春的愉悦时光之后，要给自己定一个努力的目标。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "这就是陈妍柔开始炒股的原因？当然不是。大一时的陈妍柔根本不知道什么是股票，什么叫做投资。她甚至还没想好为什么努力。一切的开端，都源自于陈妍柔寝室的另一个人。陈妍柔虽然长得不算漂亮但却是寝室里公认的开心果。在其他女孩眼中，一个没有自己长得好看并且搞笑逗逼的傻大姐人缘自然不会不好。可是这样一个好人缘的陈妍柔却并不招班花郑旖旎待见。开学第一天，两人就因为郑旖旎的名字有过一次不开心的对话。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "对于每一届的新生，学生会生活部都会在寝室门口贴好每一个寝室成员的名字。陈妍柔的名字出现在508号寝室的门上。和她一个寝室的还有宋小冉、方珊珊和之后那个第一次让她感觉三观不正的郑旖旎。"
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
