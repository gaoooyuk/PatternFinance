import QtQuick 2.5

ArticleBase {
    id: mainWindow
    totalNumberOfChars: getTotalNumberOfChars()
    estimatedReadingMins: totalNumberOfChars/700
    totalNumberOfShares: 0
    articleId: "tencent_weihuangjin"
    articleTitle: "黄金红包来袭, 大头评测腾讯微黄金“互联网+现货黄金”到底适不适合理财?"
    articleType: "评测"
    articleCategory: "物是评测"
    authorName: "大头"
    summary: ""
    from: "2017-02-05 09:32"
    coverImage: "../articledata/covers/huangjinhongbao.jpg"
    contentModel: content

    ListModel {
        id: content
        ListElement {
            type: "txt"
            content: "Hello哎喂巴德，大家新年好呀！我是磨石金融的大头，以后有什么新的金融产品面世，我都会第一时间替大家做评测。今天，就让我们一起来看一看企鹅帝国(腾讯)年后准备推出的一款集黄金、红包、理财概念于一身的产品: 黄金红包，还有它背后的“腾讯微黄金”。"
            ratio: 1
        }
        ListElement {
            type: "txt"
            content: "虚拟红包中的真金白银"
            ratio: 1
        }
        ListElement {
            type: "txt"
            content: "一句话总结黄金红包的本质，那就是通过“腾讯微黄金”撩拨大家既想发红包发的有新意，又想通过理财积累财富的小心思。“腾讯微黄金”是一款今年春节期间刚上线的贵金属交易服务，由腾讯财付通和工商银行联合推出。与支付宝之前推出的“存金宝”不同的是，“腾讯微黄金”背后交易的是现货黄金而“存金宝”则为博时黄金ETF产品。"
            ratio: 1
        }
        ListElement {
            type: "img"
            content: "../articledata/tencent_weihuangjin/pony.jpg"
            ratio: 1.77
        }
        ListElement {
            type: "txt"
            content: "春节期间，小马哥也亲测了黄金红包，大家看完截图有没有感觉挺期待呢？以前壕们发红包发的是软妹币，以后直接改发黄金了，想一想有没有一点小激动呢？大头觉着，你要是真激动的话，那真该好好冷静冷静。毕竟，无论是以软妹币为标的的现金红包，还是以现货黄金为标的的黄金红包，关键还得看能不能流通，能不能拿着红包买肉吃。"
            ratio: 1
        }
        ListElement {
            type: "txt"
            content: "现在就让我们来测评一下腾讯黄金红包和它背后的“腾讯微黄金”到底是不是一个好的理财产品。我们将从下面几个维度来看看它是不是真的适合你。"
            ratio: 1
        }
        ListElement {
            type: "txt"
            content: "1. 易用性"
            ratio: 1
        }
        ListElement {
            type: "txt"
            content: "一个金融产品是否简单易用决定了它是否适合有一般理财需求的用户。比如大头有个30岁了还在读大学的表弟，他平时爱喝金罐加多宝、喜欢吃梅林的红烧肉罐头，银行账户+支付宝+微信钱包里总共加起来也就5万块钱。他嫌股票开户太麻烦也没有投资股票的打算。在大头评测“腾讯微黄金”的时候他觉得有趣也想买点金试试，于是大头就批准他加入了微金小白鼠的行列。"
            ratio: 1
        }
        ListElement {
            type: "txt"
            content: "让我们先来看看怎样才能完成买卖微黄金的闭环操作吧。"
            ratio: 1
        }
        ListElement {
            type: "txt"
            content: "END"
            ratio: 1
        }
        ListElement {
            type: "txt"
            content: "END"
            ratio: 1
        }
    }
}