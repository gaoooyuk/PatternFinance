import QtQuick 2.5

Rectangle {
    id: mainWindow

    property int totalNumberOfChars: 0
    property int estimatedReadingMins: 0
    property int totalNumberOfShares: 0
    property string articleId: ""
    property string articleTitle: ""
    property string articleType: ""
    property string articleCategory: ""
    property string authorName: ""
    property string summary: ""
    property string from: ""
    property string coverImage: ""

    property var contentModel

    // Recomm book
    property string recommBookCover: ""
    property var recommBookInfo: []
    property string recommBookUrl: ""

    // More articles
    property var moreArticles: []

    property string apiBase: "/api"

    function qmlWidth(w) {
        return w + 1
    }

    function qmlHeight(h) {
        return h + 1
    }

    function getRandomBook() {
        var idx = Math.floor(Math.random() * recommBookModel.count)
        recommBookCover = recommBookModel.get(idx).cover
        recommBookInfo = recommBookModel.get(idx).info
        recommBookUrl = recommBookModel.get(idx).url
    }

    function getRandomArticles(num, exceptArticleId) {
        var url = apiBase + "/getRandomArticles"
        var body = {}
        body.num = num
        body.exceptArticleId = exceptArticleId
        network.httpPost(url, body, function(res) {
            try {
                moreArticles = JSON.parse(res);
            } catch(e) {
                console.log("JSON parse error(main.qml getRandomArticles): ", e)
            }
        })
    }

    function getNumberOfShares() {
        var url = apiBase + "/getArticleInfo"
        var body = {}
        body.articleId = articleId
        network.httpPost(url, body, function(res) {
            try {
                totalNumberOfShares = parseInt(res);
            } catch(e) {
                console.log("JSON parse error(main.qml getRandomArticles): ", e)
            }
        })
    }

    height: coverPanel.height
            + articlePanel.height
            + morePanel.height

    Network {
        id: network
    }

    ListModel {
        id: recommBookModel

        // 0
        ListElement {
            url: "https://union-click.jd.com/jdc?d=2n92hS"
            cover: "../imgs/books/chuangyeweijian.jpg"
            info: ["本·霍洛维茨，他是互联网先驱，与网景之父马克·安德森拍档18年，带领公司在互联网泡沫中存活下来，并最终天价卖给了惠普，震惊业界。", "他是眼光独到的投资人，其风投公司A16Z在短短三年时间内便融资27亿美元，让世界惊呼“疯子”。", "他是马克·扎克伯格等众多硅谷年轻创业家的贴身导师，投资见证了一代硅谷新贵的崛起，TwitterCEO称“本的建议是无价的”。", "今天，他将20余年的创业心得和宝贵经验写进《创业维艰》，毫无官话废话，字字干货，毫无保留。《创业维艰》中文版未出，已引发中国创业者和企业管理者的集体阅读风潮，被奉为在商学院都学不到的实战宝典。"]
        }

        // 1
        ListElement {
            url: "https://union-click.jd.com/jdc?d=wlrT9f"
            cover: "../imgs/books/buffettzhidao.jpg"
            info: ["本书是巴菲特故乡奥马哈的商店里受欢迎的图书，已经持续畅销20年。本书获得彼得·林奇，肯尼斯·费雪，橡树资本霍华德·马克思，美盛集团比尔·米勒，先锋基金约翰·博格等投资大家一致推荐。", "在《巴菲除之道》第3版中，作者不仅更精彩地描述了巴菲特60载栉风沐雨的投资之旅，还将其获取亿万财富的方法分解为12个普通人都可以学习的投资准则。新版再现了巴菲特做出重要投资决策的全过程，包括近两年的新案例，如收购亨氏食品、投资IBM，这些决策令其投资表现无可匹敌。"]
        }

        // 2
        ListElement {
            url: "https://union-click.jd.com/jdc?d=XFD62t"
            cover: "../imgs/books/gpzshyl.jpg"
            info: ["《股票作手回忆录》是一本投资领域的传世经典，再现了杰西·利弗莫尔跌宕起伏的一生，他的投资思路和操作手法也贯穿其中，向读者道出了真实的投资之道。", "《股票作手回忆录》情节跌宕起伏、激动人心，读者能充分领略到主人公当时所面临的社会环境、生活形态、市场演变、交易中的成功和失败，特别是利弗莫尔内心经历的种种滋味。时代虽然不断在变，但投资规律恒定不变。今天，本书依然对投资者具有高度的指导价值，被无数投资大师推崇。杰西·利弗莫尔，有史以来伟大的股票操盘手。他是20世纪20年代从华尔街赚走多钱的人，堪称投机行业里无出其右的奇才。他的一生充满了神秘气息和传奇，有投机之王之称，被《纽约时报》评为“百年美股人”。"]
        }

        // 3
        ListElement {
            url: "https://union-click.jd.com/jdc?d=qa5Rb4"
            cover: "../imgs/books/wujinglianzhuan.jpg"
            info: ["如果说中国有一位经济学家的意见永远值得听取的话，那就是吴敬琏。他的话常常掀起波澜，而他的话又是经济发展中不能被忽略的声音。吴敬琏先生无疑是他那一代经济学家中最才华横溢和最勤奋进取的学者之一，他在经济学研究的诸多领域都有相当的建树。", "“皂雕寒始急，天马老能行”，作为当代中国的一个符号性人物，吴敬琏的影响已经远远超越了经济学家的职业范围。他的学识、他的操守、他的社会责任感，汇集成他独特的人格魅力，感染了一代人。"]
        }

        // 4
        ListElement {
            url: "https://union-click.jd.com/jdc?d=DMVlec"
            cover: "../imgs/books/xuexizhidao.jpg"
            info: ["读完一本书，却不记得讲什么？美剧看了一箩筐，英语还是没长进？公众号、指导书、牛人帖，一个都没落，却还是没有形成自己的学习体系？这些都是典型的低质量学习症状。不了解学习的原理，就是在无效重复；缺乏有效的学习方法，就是在消耗天赋。", "本书从脑科学和心理学的最新研究出发，跨学科解读学习的原理，提供最全面的学习方法和思维模式。"]
        }

        // 5
        ListElement {
            url: "https://union-click.jd.com/jdc?d=ZbwEfE"
            cover: "../imgs/books/lianxidexintai.jpg"
            info: ["从小到大，我们在不断试错、学习新事物、练习新技能的过程中成长起来。人生中值得去做的每一件事情，都需要练习。事实上，人生本身只不过是一个漫长的练习过程，一种永无止境的优化各种行为的努力。", "适当的练习不是苦差事，而是一个有意义的过程，可以帮助你发展出耐心、专注与自律这样看似难以获得的优秀品质。在这本迷人的小书中，作者提供了简单实用的方法，帮助我们建立一种“以过程为导向”的新视角，说明如何学习生活中任何方面的技能，从打高尔夫球，到从事商业活动，再到教育孩子。"]
        }

        // 6
        ListElement {
            url: "https://union-click.jd.com/jdc?d=WFIA9n"
            cover: "../imgs/books/keyilianxi.jpg"
            info: ["4岁就会弹奏小提琴，童年时代写出多部名曲，只用一根弦也能弹完一首曲子，瞬间记住几百个随机数字，开平方比计算器还快，一秒内说出某个日子是周几，入行1年就获得世界跳高冠军，同时和26人下盲棋，14岁即成为世界象棋大师。", "所有人都以为“杰出”源于“天赋”，“天才”却说：我的成就源于“正确的练习”！著名心理学家艾利克森在“专业特长科学”领域潜心几十年，研究了一系列行业或领域中的专家级人物：国际象棋大师、顶级小提琴家、运动明星、记忆高手、拼字冠军、杰出医生等。"]
        }

        // 7
        ListElement {
            url: "https://union-click.jd.com/jdc?d=euKpfI"
            cover: "../imgs/books/moguijingjixue.jpg"
            info: ["《魔鬼经济学》，关于聪明人怎样看世界的书，畅销数十个国家的大众经济学经典。逃出认知囚笼，以经济学方式探索日常生活背后的世界，打破惯性思维，解决看似不可能解决的问题。革命性的思考、引人入胜的故事、不同寻常的分析，揭示事物表象之下真实的一面。", "当今全球超有趣的大脑，教你如何更有效、更有创造力、更理智地观察和思考。《纽约时报》、《华尔街日报》、《华盛顿邮报》、《经济学人》等全球各大媒体推荐。"]
        }

        // 8
        ListElement {
            url: "https://union-click.jd.com/jdc?d=hOfVUi"
            cover: "../imgs/books/ygzqfxsdxw.jpg"
            info: ["投资不是一门科学，而是一门艺术。除了一些基本知识之外，靠的是经验和心态。只有多思考，才能慢慢领悟。在这一点上，它与钓鱼、打高尔夫球、下棋有很多类似之处。", "在这本《一个证券分析师的醒悟》里，张化桥以专业金融从业人员和敏锐的市场观察员视角，道破股民的悲哀；直面自己的行业；解说A股上市公司境况；评议A股市场文化。"]
        }

        // 9
        ListElement {
            url: "https://union-click.jd.com/jdc?d=mEPPrO"
            cover: "../imgs/books/shbs.jpg"
            info: ["是什么导致了货币的持续超发？如何看待中国的股市？判断中国房价趋势转变的关键点是什么？当下与未来的风险和机会在哪里？大宗商品的涨跌周期如何界定？面对未来的大趋势，投资者该如何做选择？企业家应该如何决策？", "时寒冰集迄今重要的作品，集20年研究之大成。时寒冰是著名经济趋势研究专家，已出版的《时寒冰说：经济大棋局，我们怎么办》《中国怎么办——当次贷危机改变世界》《时寒冰说：欧债真相警示中国》，均为年度热销有影响力的财经图书。在这部《时寒冰说：未来二十年，经济大趋势》（分为“现实篇”和“未来篇”两本书）中，作者把20年趋势研究的成果倾囊相授，是迄今重要、有分量的作品。"]
        }

        // 10
        ListElement {
            url: "https://union-click.jd.com/jdc?d=1yeezd"
            cover: "../imgs/books/dabaijuheji.jpg"
            info: ["两册《大败局》，记录了过去20年间发生在中国企业界的、最知名的19起失败案例，并旨在探寻“中国式企业失败”的基因。", "它们都发生在一场的伟大试验中。他们都是有尊严的失败者尽管有时候，他们会漠视道德的底线和破坏他们自己参与建立的商业准则，但在更多的时候，他们投身于这个时代最伟大的试验，同时也承受着转型社会注定难以避免的阵痛、煎熬和苦难。他们以自己的失败为代价，记录了一个时代所有的光荣、梦想与悲哀。", "我们应该为悲剧鼓掌。苦难从来是成熟者的影子。"]
        }
    }

    function getTotalNumberOfChars() {
        var total = 0

        if (undefined !== contentModel) {
            for (var i = 0; i < contentModel.count; i++) {
                total += String(contentModel.get(i).content).length
            }
        }

        return total
    }

    Column {
        anchors.fill: parent

        Rectangle {
            id: coverPanel
            width: parent.width
            height: {
                if (width >= 800) {
                    return 557
                }

                return width * 0.8
            }

            Image {
                anchors.fill: parent
                source: "../imgs/mckinseyBg.jpg"
            }

            Image {
                width: parent.width
                height: qmlHeight(parent.height * 0.4)
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                source: "../imgs/coverBg.png"
            }

            Item {
                id: titlePanel
                width: contentPanel.width
                height: authorNameText.anchors.bottomMargin
                        + authorNameText.height
                        + articleTitleText.anchors.bottomMargin
                        + articleTitleText.height
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: articleTitleText
                    width: {
                        var w = qmlWidth(parent.width * 1.2)
                        if (w >= coverPanel.width) {
                            w = w * 0.8
                        }

                        return w
                    }
                    anchors.left: parent.left
                    anchors.bottom: authorNameText.top
                    anchors.bottomMargin: 20
                    wrapMode: Text.WordWrap
                    font.pixelSize: 30
                    color: "white"
                    text: articleTitle
                }

                Text {
                    id: authorNameText
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 50
                    font.pixelSize: 16
                    color: "white"
                    text: "By " + authorName
                }
            }

            Item {
                id: categoryPanel1
                width: 100
                height: 60
                anchors.top: titlePanel.top
                anchors.right: titlePanel.left
                anchors.rightMargin: 100
                visible: coverPanel.width >= 1200

                Text {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    font.pixelSize: 14
                    color: "white"
                    text: articleType
                }

                Text {
                    anchors.top: parent.top
                    anchors.topMargin: 20
                    anchors.left: parent.left
                    font.pixelSize: 14
                    font.underline: true
                    color: "white"
                    text: articleCategory
                }

                Text {
                    anchors.top: parent.top
                    anchors.topMargin: 40
                    anchors.left: parent.left
                    font.pixelSize: 14
                    color: "white"
                    text: from
                }
            }

            Item {
                id: categoryPanel2
                width: 100
                height: 40
                anchors.left: titlePanel.left
                anchors.bottom: titlePanel.top
                anchors.bottomMargin: 20
                visible: coverPanel.width >= 500 && coverPanel.width < 1200

                Text {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    font.pixelSize: 14
                    color: "white"
                    text: articleType
                }

                Text {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: 60
                    font.pixelSize: 14
                    font.underline: true
                    color: "white"
                    text: articleCategory
                }

                Text {
                    anchors.top: parent.top
                    anchors.topMargin: 20
                    anchors.left: parent.left
                    font.pixelSize: 14
                    color: "white"
                    text: from
                }
            }

            Item {
                id: categoryPanel3
                width: 100
                height: 20
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.left: titlePanel.left
                visible: coverPanel.width < 500

                Item {
                    width: typeText.width + 15
                    height: typeText.height + 6
                    anchors.top: parent.top
                    anchors.topMargin: -4
                    anchors.left: parent.left

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 2
                        radius: 5
                        color: "black"
                        opacity: 0.5
                    }

                    Text {
                        id: typeText
                        height: 20
                        anchors.centerIn: parent
                        font.pixelSize: 14
                        color: "white"
                        text: articleType
                    }
                }

                Text {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: 60
                    font.pixelSize: 14
                    font.underline: true
                    color: "white"
                    text: articleCategory
                }

                Text {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: 150
                    font.pixelSize: 14
                    color: "white"
                    text: from
                }
            }
        }

        Rectangle {
            id: articlePanel
            width: parent.width
            height: articleSummaryPanel.height + articleContentPanel.height

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
                        id: articleSummaryPanel
                        width: parent.width
                        height: summaryText.height + 200

                        Rectangle {
                            id: sPanel
                            width: parent.width
                            height: summaryText.height + 50
                            anchors.top: parent.top
                            anchors.topMargin: 20
                            color: "#FAFAF9"

                            Text {
                                id: summaryText
                                width: qmlWidth(contentPanel.width * 0.9)
                                anchors.centerIn: parent
                                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                lineHeight: 30
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: "导读：" + summary
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
                            text: "文章字数：" + totalNumberOfChars
                        }

                        Text {
                            anchors.top: sPanel.bottom
                            anchors.topMargin: 37
                            anchors.left: sPanel.left
                            font.pixelSize: 16
                            font.weight: Font.Light
                            color: "#4a4a4a"
                            text: "阅读时长：" + estimatedReadingMins + " mins"
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

                            h += contentLayout.spacing * (contentLayout.children.length - 1)

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
                                    height: textItem.height

                                    Text {
                                        id: textItem
                                        width: qmlWidth(contentPanel.width)
                                        wrapMode: Text.WordWrap
                                        lineHeight: 30
                                        font.pixelSize: 18
                                        color: "#4a4a4a"
                                        text: content
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Sharebar {
                anchors.top: contentPanel.top
                anchors.topMargin: 20
                anchors.right: contentPanel.left
                anchors.rightMargin: 20
                visible: mainWindow.width >= 1000

                articleId: mainWindow.articleId
                articleUrl: "https://www.patternfinance.com/article/" + mainWindow.articleId
                articleCover: mainWindow.coverImage
                articleTitle: mainWindow.articleTitle
                numberOfShares: totalNumberOfShares
            }
        }

        Item {
            id: morePanel
            width: mainWindow.width
            height: {
                if (mainWindow.width >= 800) {
                    return 1100
                }

                if (mainWindow.width >= 600 && mainWindow.width < 800) {
                    return 2000
                }

                return 1800
            }
            anchors.horizontalCenter: parent.horizontalCenter

            Image {
                id: moreBg
                anchors.fill: parent
                fillMode: Image.Tile
                source: "../imgs/interlaced-gray-bg.png"
            }

            Column {
                anchors.fill: parent

                Item {
                    id: morePanelInner
                    width: {
                        if (articlePanel.width >= 1440) {
                            return 1440
                        }

                        return qmlWidth(mainWindow.width * 0.9)
                    }
                    height: parent.height - morePanelSpacer.height
                    anchors.horizontalCenter: parent.horizontalCenter

                    Item {
                        id: moreArticlePanel
                        width: {
                            if (mainWindow.width >= 1500) {
                                return qmlWidth(morePanelInner.width * 0.75)
                            }

                            return qmlWidth(morePanelInner.width * 0.85)
                        }

                        height: parent.height - anchors.topMargin
                        anchors.top: parent.top
                        anchors.topMargin: 60
                        anchors.left: parent.left
                        anchors.leftMargin: {
                            if (mainWindow.width >= 1500) {
                                return 0
                            }

                            return (morePanelInner.width - moreArticlePanel.width) / 2
                        }

                        Column {
                            anchors.fill: parent

                            Item {
                                id: moreActiclePanelTitleBar
                                width: parent.width
                                height: 40

                                Text {
                                    anchors.left: parent.left
                                    font.pixelSize: 20
                                    color: "#4a4a4a"
                                    text: "更多文章"
                                }

                                Rectangle {
                                    width: parent.width
                                    height: 2
                                    anchors.bottom: parent.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    color: "#d8d8d8"
                                    opacity: 0.8
                                }
                            }

                            Item {
                                id: moreActiclePanelSpacer1
                                width: parent.width
                                height: 20
                            }

                            Grid {
                                id: moreArticleGrid
                                width: parent.width
                                height: parent.height
                                        - moreActiclePanelTitleBar.height
                                        - moreActiclePanelSpacer1.height
                                rows: {
                                    if (mainWindow.width >= 800) {
                                        return 2
                                    }

                                    return 4
                                }
                                columns: {
                                    if (mainWindow.width >= 800) {
                                        return 2
                                    }

                                    return 1
                                }

                                Repeater {
                                    model: 4
                                    delegate: Item {
                                        width: moreArticleGrid.width / moreArticleGrid.columns
                                        height: moreArticleGrid.height / moreArticleGrid.rows

                                        Item {
                                            anchors.fill: parent
                                            anchors.leftMargin: {
                                                if (2 === moreArticleGrid.columns) {
                                                    if (0 === index % 2) {
                                                        return 0
                                                    }

                                                    return 20
                                                } else {
                                                    return 0
                                                }
                                            }
                                            anchors.rightMargin: {
                                                if (2 === moreArticleGrid.columns) {
                                                    if (0 === index % 2) {
                                                        return 20
                                                    }

                                                    return 0
                                                } else {
                                                    return 0
                                                }
                                            }
                                            anchors.bottomMargin: 40

                                            Column {
                                                anchors.fill: parent

                                                Image {
                                                    width: parent.width
                                                    height: qmlHeight(width * 0.56)
                                                    source: {
                                                        if (undefined !== moreArticles[index]) {
                                                            return moreArticles[index].cover
                                                        }

                                                        return ""
                                                    }
                                                }

                                                Item {
                                                    id: typeBar
                                                    width: parent.width
                                                    height: 50

                                                    Text {
                                                        anchors.left: parent.left
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        font.pixelSize: 14
                                                        color: "#9b9b9b"
                                                        text: {
                                                            if (undefined !== moreArticles[index]) {
                                                                return moreArticles[index].type
                                                            }

                                                            return ""
                                                        }
                                                    }

                                                    Text {
                                                        anchors.left: parent.left
                                                        anchors.leftMargin: 40
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        font.pixelSize: 14
                                                        font.underline: true
                                                        color: "#9b9b9b"
                                                        text: {
                                                            if (undefined !== moreArticles[index]) {
                                                                return moreArticles[index].category
                                                            }

                                                            return ""
                                                        }
                                                    }
                                                }

                                                Item {
                                                    id: titleTextBar
                                                    width: parent.width
                                                    height: titleText.height + 10

                                                    Text {
                                                        id: titleText
                                                        width: qmlWidth(parent.width * 0.95)
                                                        anchors.left: parent.left
                                                        font.pixelSize: 20
                                                        wrapMode: Text.WordWrap
                                                        color: "#4a4a4a"
                                                        text: {
                                                            if (undefined !== moreArticles[index]) {
                                                                return moreArticles[index].title
                                                            }

                                                            return ""
                                                        }
                                                    }
                                                }

                                                Item {
                                                    id: ledeTextBar
                                                    width: parent.width
                                                    height: ledeText.height

                                                    Text {
                                                        id: ledeText
                                                        width: qmlWidth(parent.width)
                                                        anchors.left: parent.left
                                                        font.pixelSize: 18
                                                        wrapMode: Text.WordWrap
                                                        color: "#9b9b9b"
                                                        text: {
                                                            if (undefined !== moreArticles[index]) {
                                                                return moreArticles[index].lede
                                                            }

                                                            return ""
                                                        }
                                                    }
                                                }
                                            }

                                            GeneralMouseArea {
                                                onClicked: {
                                                    var url = "https://www.patternfinance.com/article/" + moreArticles[index].articleId
                                                    Qt.openUrlExternally(url)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Item {
                        id: bookPanel
                        width: qmlWidth(morePanelInner.width * 0.2)
                        height: parent.height - anchors.topMargin
                        anchors.top: parent.top
                        anchors.topMargin: 60
                        anchors.right: parent.right
                        visible: mainWindow.width >= 1500

                        Column {
                            anchors.fill: parent

                            Item {
                                id: bookPanelTitleBar
                                width: parent.width
                                height: 40

                                Text {
                                    anchors.left: parent.left
                                    font.pixelSize: 20
                                    color: "#4a4a4a"
                                    text: "推荐书籍"
                                }

                                Rectangle {
                                    width: parent.width
                                    height: 2
                                    anchors.bottom: parent.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    color: "#d8d8d8"
                                    opacity: 0.8
                                }
                            }

                            Item {
                                id: bookPanelSpacer1
                                width: parent.width
                                height: 20
                            }

                            Image {
                                width: parent.width
                                height: width
                                source: recommBookCover
                            }

                            Item {
                                id: bookPanelSpacer2
                                width: parent.width
                                height: 10
                            }

                            Item {
                                id: jdzyEntry
                                width: parent.width
                                height: 30

                                Item {
                                    width: 67
                                    height: 30
                                    anchors.right: parent.horizontalCenter
                                    anchors.rightMargin: 20
                                    anchors.verticalCenter: parent.verticalCenter

                                    Rectangle {
                                        anchors.fill: parent
                                        anchors.margins: 4
                                        border.width: 1
                                        border.color: "#F25352"
                                        radius: 3
                                        color: "transparent"

                                        Text {
                                            height: 18
                                            anchors.centerIn: parent
                                            font.pixelSize: 12
                                            color: "#F25352"
                                            text: "京东自营"
                                        }
                                    }
                                }

                                Rectangle {
                                    width: 100
                                    height: 30
                                    anchors.left: parent.horizontalCenter
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
                                        Qt.openUrlExternally(recommBookUrl)
                                    }
                                }
                            }

                            Item {
                                id: bookPanelSpacer3
                                width: parent.width
                                height: 50
                            }

                            Item {
                                id: bookInfoBar
                                width: bookPanel.width
                                height: {
                                    var h = 0
                                    for (var i = 1; i < recommBookLayout.children.length; i++) {
                                        h += recommBookLayout.children[i].height
                                    }

                                    h += recommBookLayout.spacing * (recommBookLayout.children.length - 1)

                                    return h
                                }

                                Column {
                                    id: recommBookLayout
                                    anchors.fill: parent
                                    spacing: 30

                                    Repeater {
                                        model: recommBookInfo
                                        delegate: Text {
                                            id: bookInfoText
                                            width: 289
                                            font.pixelSize: 16
                                            lineHeight: 30
                                            wrapMode: Text.WordWrap
                                            color: "#4a4a4a"
                                            text: recommBookInfo[index]
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Item {
                    id: morePanelSpacer
                    width: parent.width
                    height: 50
                }
            }
        }
    }

    Component.onCompleted: {
        getNumberOfShares()
        getRandomArticles(4, mainWindow.articleId)
        getRandomBook()
    }
}
