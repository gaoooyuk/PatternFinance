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
            content: "这就是陈妍柔开始炒股的原因？当然不是。大一时的陈妍柔根本不知道什么是股票，什么叫做投资。她甚至还没想好为什么努力。一切的开端，都源自于陈妍柔寝室的另一个人。陈妍柔虽然长得不算漂亮但却是寝室里公认的开心果。在其他女孩眼中，一个没有自己长得好看并且搞笑逗逼的傻大姐人缘自然不会太差。可是这样一个好人缘的陈妍柔却并不招班花郑旖旎待见。开学第一天，两人就因为郑旖旎的名字有过一次不开心的对话。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "对于每一届的新生，学生会生活部都会在寝室门口贴好每一个寝室成员的名字。陈妍柔的名字出现在508号寝室的门上。和她一个寝室的还有宋小冉、方珊珊和之后那个第一次让她感觉三观不正的郑旖旎。和郑旖旎的不愉快源自于陈妍柔脑子里时不时冒出的奇怪想法。当她和另外两个室友看到贴在寝室门上各种通知旁边的成员名单时，她们已经收拾好自己的床铺，并且熟稔又不失礼貌的交谈过关于自己的家乡和高中时代了。陈妍柔从来都不是一个挑事的人，但她时常脑子短路。“好吧！让我们一起期待我们的最后一个室友郑方方吧！”， 当她看到郑旖旎名字时她竟然忘记了那两个字该怎么念。从小搞怪的陈妍柔显然没有忘记小学语文老师的顺口溜“成都人生的偏，认字认半边”。她半开玩笑半遮掩地为自己的稀里糊涂找借口，却没曾想被刚好提着行李箱来寝室的郑旖旎听到。陈妍柔是个细腻的人，但多年后她也回忆不起后来争吵是否只是因为自己的玩笑。她只记得那天的郑旖旎似乎穿着一身与自己格格不入的衣服，似乎还化了妆。后来的陈妍柔与室友们都知道了郑旖旎这样打扮的原因，但在那一天那一刻，虽然诧异，但在陈妍柔幻想的世界里，这只是一次“不打不相识”的开场，她有信心和这个女孩在今后的四年里愉快相处。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "陈妍柔拉了拉自己的外套。从靠在沙发垫到蜷缩成一团，陈妍柔感觉这样并不能让感冒带来的寒意衰减半分，反而让自己无法肆意的舒展。每一次的挪动都伴随着倒灌而来的冷气。关上电视，打开笔记本电脑，陈妍柔终于决定还是得起来动动，哪怕只是动动手指。比起在女孩感冒时让她喝热水，让她逛逛心仪的网店似乎更能激发她的求生欲望。陈妍柔一边一样想着，一边打开了网页收藏夹里的蒂芙尼网站。“Tiffany T系列线圈手镯，人民币1万5千元，下个月生日前争取拿下你！”陈妍柔呢喃着，似乎这次下定了决心。手镯在屏幕里一圈又一圈的旋转着，闪耀着光芒，将陈妍柔带回到四年前的某个午后。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "如果说陈妍柔开始炒股是因为郑旖旎，那么陈妍柔希望当初自己的初衷是为了更自由地活着。在大一上期课程结束后，陈妍柔并没能如自己所愿的与郑旖旎成为能够愉快相处的朋友。郑旖旎似乎不想与她们寝室的任何一个人成为朋友。室友宋小冉来自湖北武汉，有着紧致的身体线条和修长笔直的大腿。宋小冉是个漂亮的女孩，至于聪不聪明，那个时候的陈妍柔并不知道，也不关心。每次室友间八卦时光的发起人也是宋小冉。陈妍柔本身并不是一个八卦的人，但她喜欢这种略带有推理情节的娱乐项目。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "“听班上男生说郑旖旎好像有男朋友了。不过，好像是个大叔！”宋小冉似乎很兴奋地说道。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "“哪个说的哦，靠不靠谱，从来没听她提过啊！”方珊珊一边发问，一边埋头写着《经济学原理》的作业。方珊珊和陈妍柔一样是个土生土长的成都姑娘，既有锦官城女孩的娟秀灵气，也有泼辣的一面。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "宋小冉坏笑道：“还能有谁，不就是那个暗恋班花的大头张”。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "大头张？张大头？陈妍柔竖着耳朵关注着这场难得的桃色新闻。郑旖旎在寝室待着的时间并不多，除了学校必修课不会缺席外，她的行踪总是飘忽不定。那么大头张又是谁？陈妍柔没有直接问出口，她向来都是那个在最后一刻才展开真相推理的人。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "“张潼亲眼看见的？”方珊珊偏了偏头，似乎在看下一道题目，不知道是不是因为郑旖旎的桃色新闻不够劲爆，她看起来并没有停下手中作业的打算。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "原来是他。陈妍柔对这个被叫做大头的同学还算有印象，其实他的头也不算太大。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "宋小冉道：“听他说是昨天晚上从网吧回来的路上撞见的，隔着一条街，看见一个男的开车送她回学校”。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "“看清楚没有，是大叔还是欧巴，不会是她亲戚吧？”方珊珊停下手中的笔，看起来她对对方的身份颇感兴趣。"
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
