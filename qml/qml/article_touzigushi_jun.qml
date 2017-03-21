import QtQuick 2.5
ArticleBase {
    id: mainWindow
    totalNumberOfChars: getTotalNumberOfChars()
    estimatedReadingMins: totalNumberOfChars/700
    totalNumberOfShares: 0
    articleId: "touzigushi_jun"
    articleTitle: "“傻一点、轴一点”：基金经理诠释一万小时天才秘诀"
    articleType: "文章"
    articleCategory: "投资故事"
    authorName: "马赛客"
    summary: "他几乎从零开始，在上海买房，两辆车，都是从这个市场赚来的"
    from: "2017-03-21 10:36"
    coverImage: "https://pic3.zhimg.com/v2-0f1e67f3e17cf23287d2b9c01c5ae1d6_r.jpg"
	contentModel: content
	tocModel: toc
	ListModel { 
        id: content
        ListElement { 
            type: "txt"
            ratio: 1
            content: "编者按: 本文来自<strong>交易门</strong>联合创始人<strong>马赛客</strong>。交易门是一家聚焦中国金融交易生态圈，跟踪记录业界鲜活个体的新媒体。如果你喜欢他们的文章，你也可以微信订阅：<strong>Tradingmen</strong>"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "交易至今，2010年过山车的经历对土匀影响至深。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "土匀2010年8月开通期货账户，他先后在两家期货公司就职，都是做客服工作。第一家期货公司交易氛围很浓，除了交易量比较大的炒手，公司内部的人也做单。土匀说，大家并不在意工作，“每天像打牌一样，聚在一起讨论行情和交易”。股指期货开出之后，团队同事各自散去，有人进资管，有人开私募，公司也逐渐在行业中没落。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "在第二家期货公司，新组建的客服部共三人，土匀入职两个星期领导就辞职了。“我和另外一个同事就成孤儿了。”公司把土匀和另一个同事扔到了研发部。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "土匀尝试报考CPA（注册会计师），9月份考下来只过了一门，宣布放弃。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "9月30日，土匀做了期货生涯第一单实盘交易，三万元本金，在豆油期货上挣了600元。第一个月，他的交易毫无逻辑，“就是乱做，进进出出”。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "土匀告诉我，像他那样的散户，三个月足以被淘汰出局，但他运气不错。“11月份，有幸碰到了到现在来看都是最暴力的行情，PTA连续五个板，我扎扎实实地吃到了三个板。”"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "第三个板之后，土匀的一手PTA被协议平仓，两万元变成了三万四。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "“哇好开心啊，真的真的真的好开心。你不知道这种开心是有多开心。”说到这，土匀会把视线挪开几秒，切入当时的画面。做到现在，土匀对盈亏的敏感度已经大不如前，他一天亲自交易产生的手续费都可能过十万。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "土匀想，按照这种赚钱的速度，他不用工作了。“真的会有这种想法。”土匀强调说。一个基本工资只有四千元的人，三四天时间就赚了一万四，有点想法是可以理解的。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "1990年代入行的资深操盘手关工曾说，很多事情都是呈对称性的，“上去得越陡，下来得越快”。也就两三天时间，土匀的三万四就回到了两万元。"
        }
        ListElement { 
            type: "sectionHeader"
            ratio: 1
            content: "1"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "“我记得非常清楚，那天我坐地铁，再倒一趟公交车，在公交车上哭了半个小时。我就觉得我这辈子大概就是一事无成了。做股票不行，工作不行，现在做期货，还是亏。”土匀大三时做过一阵股票，在大盘6000点时（2007年10月）入场。三年后入场做期货，境况依然不妙。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "土匀大学读的是电气工程自动化专业，毕业后短暂地在振华重工待了一个月，参与安装工作。这个工作核心部分都是国外团队在做，土匀的工作可替代性很强，还要经常出差，远至非洲、美洲。哪个港口买了公司的桥吊，他们就要前往参与安装调试。如果不出差，他办公也是在崇明岛、长兴岛这样的地方。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "土匀从小在上海长大，上大学也在上海。他想象中的工作，应该是在陆家嘴，西装革履。他放弃了振华重工的工作，扎进金融行业。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "2009年全球金融危机余波未了，行情很不景气。土匀考了各种从业资格证，想找一个研究员、分析师的工作，却连做经纪人、客户开户岗的机会都没有。最后他找到一个客服岗的工作，2800元一个月。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "土匀每天坐公交车转二号线，从陆家嘴站拥挤的人群中挣脱出来时，他觉得终于上了层次，生活有了奔头。那时土匀还不理解，每个行业风光无限的，都只是金字塔顶端的人，“XX狗”也还没成为各行业金字塔底端芸芸众生的代名词。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "金融圈的残酷和底层的寡淡，加上金融危机的冲击，给了新入行的土匀亲切的问候。在期货公司，土匀陷入了看不到未来的迷茫。“学历不高，专业不对口，做业务，喝酒又不行。”就算把CPA考下来，他觉得改观也不大。做交易是他能想到的改变自己最直接的方式。只是开始做交易时他还没有做好亏钱的准备。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "“可能在别人看来这一万块钱不算什么，亏了也就亏了。我相信（即便）现在每天市场上亏钱爆仓的人（依然）不计其数。”土匀说，“但那时候对我来说，可能这辈子就没希望了。”"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "土匀没有退路。辗转两年想退回去重操旧业几无可能，他对做工程师毫无自信。“从小我就不是一个动手能力强的人。我做厨师大概比这个（做工程师）要好一点，做个街边小贩，摊个蛋饼什么的。我做中介可能也比这个好。”土匀说。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "回到家冷静下来，土匀觉得还是要做交易，不能放弃。毕业两年，同学之间的差距不断突显——工作、收入、社会地位。土匀有一种本能的出人头地的冲动，一定要赚到钱。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "土匀想到自己这一年5月份开始做的股指期货的模拟交易。"
        }
        ListElement { 
            type: "sectionHeader"
            ratio: 1
            content: "2"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "在第二家期货公司的研发部，土匀和另外三个研究员几乎天天泡在一起探讨行情，交流策略。他们有人擅长基本面，有人擅长写程序。土匀有写程序的基础，开始写程序寻找交易信号。“那时候很简单的，均线突破类似（三五分钟），多头排列空头排列，设置好出场。”"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "土匀在商品期货坐过山车时，他模拟的股指期货交易一直表现不错。“总比我这么在里面乱做强啊，至少曲线是向上的。”他决定放弃主观交易，用程序来指导自己的交易。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "土匀坚持做一手螺纹钢，一小时线的均线突破，模型给信号，手动敲单。几年后谈起，土匀说这段经历对锻炼他的心性帮助很大。“这种交易按部就班，盘中是没有什么成就感的，让你进场就进场，让你出就出，不能反抗。盘子每天上上下下，其实也看不出什么东西，但模型有时候几天才给一个信号，你要坐得住。”"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "土匀傻瓜式地坚持按这个交易模型执行。他的生活寡淡，不谈恋爱，没有业余消遣，顶多打打实况足球。“我主观做得实在是太失败了。另外就是那条路我走得也不是很长，给我的固有的东西不多。”土匀解释说，“我觉得这种方式，就是要傻一点，要轴一点。只有这样我才能生存下去，如果不这样，可能明天我就是流落街头，一分钱也赚不到。所以到现在，我所有的策略，我不去干扰他。这就是这么多年来我唯一信仰的标准。因为没有了它，我就没有了空气。”"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "三个月下来，土匀觉得自己状态已经比较稳定，不会有大的风险。他把股票账户的钱取出来，凑了10万，另外的钱来自他妈妈的一个朋友，还有他姨妈。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "“这真的是运气。”土匀多次用“运气”来描述自己的成长之路，“未来能做成怎样，我认为是早有安排。”凑够10万块钱，土匀开始建立组合头寸，做螺纹钢、PTA和锌。“钱太少很难发展，钱太多怕亏完了。有外部的钱，对你也是一种约束。”"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "在跟市场的博弈中，土匀延续了主观操作的运势。2011年8月份，土匀在家里休年假。一天他兴奋地告诉妈妈：我今天就赚了一万五，好开心！第二天，第三天，他的脸色一天比一天难看。他深刻地认识到这个市场的残酷性，亏亏赚赚，赚赚亏亏，无限折磨。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "土匀的妈妈告诉我，邻居得知土匀做期货，经常劝她要儿子收手，说期货不能碰，要倾家荡产。她倒是不太紧张儿子亏钱，但的确看不到明朗的希望，多次劝儿子考公务员。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "跟前面讲到的过山车之后暴力的PTA行情相似，紧接着的9月中旬到9月底，一波非常流畅的下跌让土匀的10万元一度翻倍，行情结束后他回吐了2万利润。至此土匀相信，他的策略可以挣钱了。"
        }
        ListElement { 
            type: "sectionHeader"
            ratio: 1
            content: "3"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "趋势交易依赖趋势行情，震荡市往往比较难受。2011年10-12月份，宽幅震荡几乎吞噬了土匀前两个月3/4的利润。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "土匀想出一个应对震荡行情的方法，做一个买强卖弱的组合，比如上海期货交易所的螺纹钢和锌，或者天然橡胶和螺纹钢。“那时候我Matlab做得很好，也不知道怎么来的力量。”测试下来效果不错，实盘竟然也出奇地好。“我每天只要进去，一定可以赚个一两千。”"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "有一天回到家，土匀得意地跟妈妈说：“你儿子找到了这个市场的ATM机。”似曾相似的自信又来了，这回的区别在于，土匀表现得更狂傲一些。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "遗憾的是，几个月做下来，市场并没有如期成为土匀的提款机。2012年1月到4月，他的净值不断回撤，账户逼近10万的起点，不免有些慌乱。土匀承认，自己做的是“非常无脑的组合”，因为他选择的品种，相关度并不是那么高，甚至不是一个大类品种。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "意识到这个问题之后，土匀才把配对交易放在高度相关的大类品种，形成稳定的交易模式。这套交易模式他沿用至今，选择的行业、品种会有变化，但是交易思路一脉相承。有趣的是，土匀曾经拿这个策略思路去跟投资公司“路演”，得到的回答是“策略不行”。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "配对交易加趋势交易，形成土匀主要的策略类别。2012年底，土匀基本上摆脱了财务上的窘境，年底还买了第一辆车。“那时候赚了钱的开心程度，比现在自己的钱一个月赚100万还开心。”"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "拿着这一年的业绩，土匀开始吸引外部资金，100万，200万，2000万。做完2013年，土匀辞掉了期货公司的工作。"
        }
        ListElement { 
            type: "img"
            ratio: 0.75
            content: "http://pic4.zhimg.com/v2-8eb652bad8123eedd8410116e889ddff_b.jpg"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "这是土匀在三亚度假的照片。土匀跟老婆结婚时还没什么钱，他们第一次去三亚度假，第一次住在海边，觉得很开心。“现在随随便便都可以去三亚，坐头等舱，住最好的海景房，你也没有觉得比那时候更幸福。”土匀说。"
        }
        ListElement { 
            type: "sectionHeader"
            ratio: 1
            content: "4"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "现在土匀的私募基金管理规模近3亿，一只产品刚刚夺得某个榜单衍生品组的亚军。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "从期货公司客服到私募基金创办人，土匀花了六年时间。他的经验是：保持不死，保持热情。“前两年你只要每天进进出出，能打平，我认为你未来赚来的概率就会很大，最怕一下赚很多，又爆亏，到最后你自己都没信心。”土匀说，“我们脑子也不算特别聪明，也不是学霸，到这个程度基本上靠坚持。”"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "有四年多的时间，土匀的生活几乎只有期货，即便恋爱结婚，他留给另一半的时间也很少。土匀的太太告诉我，土匀每天回家都守在电脑桌前，即便是发高烧都要工作，雷打不动。这让家人一度非常担心他的健康。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "为了让自己能够在这种煎熬中活下来，土匀称自己每天都要想上成千上百遍葛卫东、叶庆均、林广茂等大神的名字。“大部分时间活的我认为是蛮痛苦的，一年就几天是开心的吧。”"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "从公司发展的角度讲，现在正是土匀需要营销自己的时候，但他要求我隐去他的姓名，也不必谈他的公司。他说，之所以愿意跟"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "土匀说，自己能走出来全靠市场给机会，运气好，但交易也符合“一万小时天才理论”。他坚信，只要努力，期货、期权交易可以“赚中产阶级以上的钱，你一年赚个50到100万，不是很难的事情，在我看来”。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "他几乎从零开始，在上海买房，两辆车，都是从这个市场赚来的。"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "当然，对“努力”的界定可能因人而异，执行力也会千差万别。土匀的版本是这样："
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "“基本上那时候我除了交易，感觉生命里没有其它的东西。四年多时间，一年365天，至少360天，每天至少在这上面花12个小时。包括现在，每天我都是亲力亲为干到第一线。我下面有交易员，但我每天还承担了大量的交易工作。”"
        }
        ListElement { 
            type: "txt"
            ratio: 1
            content: "END"
        }
	}
    ListModel {
        id: toc
        ListElement {
            title: "1"
        }
        ListElement {
            title: "2"
        }
        ListElement {
            title: "3"
        }
        ListElement {
            title: "4"
        }
        ListElement {
            title: "END"
        }
    }
}
