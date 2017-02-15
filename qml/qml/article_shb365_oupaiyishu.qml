import QtQuick 2.5

ArticleBase {
    id: mainWindow
    totalNumberOfChars: getTotalNumberOfChars()
    estimatedReadingMins: totalNumberOfChars/700
    totalNumberOfShares: 0
    articleId: "shb365_oupaiyishu"
    articleTitle: "大头物是评测：号称40天收益200%的书画宝深度揭秘"
    articleType: "评测"
    articleCategory: "物是评测"
    authorName: "大头"
    summary: "让大妈们趋之若鹜的书画宝究竟是一场商业模式的创新，还是一场“群鸦的盛宴”？"
    from: "2017-02-10 13:22"
    coverImage: "../articledata/covers/shb365.png"
    contentModel: content

    ListModel {
        id: content
        ListElement {
            type: "txt"
            ratio: 1
            content: "号称40天收益200%的书画宝究竟是难得一遇的千里马，还是公然暗仓操作的大忽悠，大头带你揭秘瓯派艺术和shb365.com"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "书画宝的前世今生"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "一篇来自理财不二牛(微信号buerniu5188)的文章将书画宝和它背后的瓯派艺术带进了大家的视线。面对传说中40天收益就能有200%、投10万就能赚20万的天大馅饼，大头也难以免俗地想问一问：这种好事哪里还有？好像损失了几个亿的大头决定好好挖一挖书画宝背后的生意。然后和大家一起探讨一下它的投资可行性。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "尽管从各家媒体的态度上就可以明显地感觉到书画宝可能是个大忽悠，但大头还是想听听书画宝自己怎么说。本着偏听则暗兼听则明的态度，大头认认真真地阅读了2月9日书画宝发布在其官网上的一篇“红头”文件。"
        }
        ListElement {
            type: "img"
            ratio: 1.63
            content: "../articledata/shb365_oupaiyishu/shb_gonggao.png"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "从这篇公告的内容上看，书画宝的出现是为了响应国家文化创新的号召，意在文化产业供给侧改革。从措辞和行文上看，书画宝和其背后的瓯派艺术似乎对其产品颇为满意，称解决了整个书画行业的所有痛点。而“平台刚起步不久”也成了书画宝面对近期媒体曝光和质疑的最佳搪塞之词。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "当然，only if 这一切都不是假大空。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<strong>那么书画宝究竟是怎样一款产品呢？</strong>让我们先从欧派艺术说起。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "欧派艺术，全称温州瓯派文化艺术有限公司。根据天眼查提供的公开企业信息，我们可以了解到一些需要注意的东西。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "1. 在2014年6月，由“温州市山青水秀<strong>环境工程</strong>有限公司”改名为现在的“温州瓯派<strong>文化艺术</strong>有限公司”。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "2. 从2015年欧派艺术公示的年度报告中可以发现，其实缴出资额为205万元，股东为史红彬和张春霞。"
        }
        ListElement {
            type: "img"
            ratio: 0.93
            content: "../articledata/shb365_oupaiyishu/oupai_2015.png"
        }
        ListElement {
            type: "img"
            ratio: 0.63
            content: "../articledata/shb365_oupaiyishu/ir.png"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "3. 从历年年报(2013-2015)上看，欧派艺术为一人有限责任公司(私营法人独资)，实际的老板为史红彬。在2013和2014年这两年间企业从业人数为3人，而2015年则选择了不公示。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "4. 除了瓯派艺术和瓯派国信分公司(陈占兴)外，史红彬和另一股东张春霞还参股了上海红唐文化科技股份有限公司(以下简称红唐文化)。而从欧派艺术和红唐文化的商标申请信息上来看，“字画宝”、“书画宝”，“字画云”、“书画云”，这似乎很符合互联网+的理念。"
        }
        ListElement {
            type: "img"
            ratio: 0.49
            content: "../articledata/shb365_oupaiyishu/shb_shangbiao.png"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "除了以上这些，史红彬也许还亲自用QQ邮箱注册了shb365.com和另一个域名www.qqysjyw.com(内容指向shb365.com，并且从联系人信息上看，史红彬在2014年的时候也许想做的只是一个书画研究院)。"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "究竟是平台红利还是庞氏骗局？"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "超高额的收益预期使得投资者们趋之若鹜。这带来的到底是企业从此一路高歌猛进还是谎言被戳破后众人的失望？大头希望这不是一场“群鸦的盛宴”。"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "史红彬是谁？"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "混迹民间的商人总是喜欢一些夸大而不实的称谓。史红彬也不免其俗。从欧派艺术的宣传上来看，其“带头大哥”也有着不只一种身份。书画宝创始人、全球艺术交易网创始人、瓯派文化董事长、瓯派艺术研究院创始人，似乎有了这些光环的加持，史总的生意就能顺风顺水。大头显然不是一个喜欢刨根问底的人，但老板说要深度，看在操守(gongzi)的份上就只有对不起别人家史大大了。毕竟大头老板经常告诫大头: 写评测除了要严肃活泼，还要有理(tucao)有据(tucao)有节(tucao)。"
        }
        ListElement {
            type: "img"
            ratio: 0.75
            content: "../articledata/shb365_oupaiyishu/shb_titles.png"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "首先让我们来看看(tucaoyixia)这个全球艺术交易网。大家还记不记得除了shb365.com之外，史红彬在2014年的时候还注册过一个域名(www.qqysjyw.com)。是不是有点眼熟？这不就是全球艺术交易网的拼音吗！如果你现在访问这个域名的话，你会看到和书画宝网站完全相同的内容。"
        }
        ListElement {
            type: "img"
            ratio: 0.36
            content: "../articledata/shb365_oupaiyishu/qqysw.png"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "在瓯派艺术的百度贴吧上也有着这么一段对史总的介绍。大头这才明白，怪不得史总能赚大钱，这一个西瓜子掰两半的方法还真是好用。作为吃瓜群众的大头觉得用来唬唬大爷大妈这也算够用了。"
        }
        ListElement {
            type: "img"
            ratio: 0.77
            content: "../articledata/shb365_oupaiyishu/euca.png"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "内部操作坐庄？"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: ""
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "大头还注意到，瓯派艺术还可能在交易流程的设计上获利。而其中最明显的一点就是在“艺术资源包”认购期内(分为内部认购和公开认购)可以通过支付宝(余额宝)大量“囤积”资金。以其2月6日发布的“东方之韵”艺术包为例，在认购期内(2月6日-2月14日)共有23200平尺接受认购。根据其认购页面862元每平尺的报价，如果完全预定，书画宝可“募集”的本金大约为2000万(根据其规则设计也可能高出其总价)。而仅此一项，就可以在10天内为书画宝带来约2万元的余额宝收入。"
        }
        ListElement {
            type: "img"
            ratio: 0.31
            content: "../articledata/shb365_oupaiyishu/shb_ziyuanbaodinggou.png"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<strong>插播大头招聘广告一条</strong> <br>如果你对某个金融产品不吐不快，或者成为“物是评测”的专栏作者，现在就联系我吧: datou@patternfinance.com"
        }
    }
}
