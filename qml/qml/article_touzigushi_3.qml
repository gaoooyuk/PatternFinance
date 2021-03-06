import QtQuick 2.5

ArticleBase {
    id: mainWindow
    totalNumberOfChars: getTotalNumberOfChars()
    estimatedReadingMins: totalNumberOfChars/700
    totalNumberOfShares: 0
    articleId: "touzigushi_3"
    articleTitle: "一枚硬币走天下，十二年的酸甜苦辣"
    articleType: "文章"
    articleCategory: "投资故事"
    authorName: "一枚硬币走天下"
    summary: "买别墅、送孩子留学、开豪车。看“一枚硬币走天下”12年股市浮沉。"
    from: "转载自天涯 2017-02-06"
    coverImage: "../articledata/covers/yimeiyingbi.png"
    contentModel: content
    tocModel: toc

    ListModel {
        id: content
        ListElement {
            type: "txt"
            ratio: 1
            content: "我是2000年进入的股市，刚开始是听朋友说他的一个朋友炒股很厉害，好像是一个很大的集团公司的财务总监，一起吃过几次饭后，我和朋友都在他的带领下在华夏证券（印象中，不是很确定了）开了户，将账户全部交给他全权操作。我记得我存入的金额是二十三万（230000元）。后来就没有管过，也不知道怎么操作。大约一年左右时间后的某一天，朋友跑来说，不好了，他的那位朋友炒股亏了好多钱，好像是两口子都离婚了，于是我们赶紧到证券公司去看账户，我好像还剩九万三千元。想想很心痛，赚钱很不容易，一年就亏掉一半多，感觉就是痛木了。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "于是自己开始学着做股票，看基本面，研究k线，看各种书籍。总之散户做的这些我都做。02年的时候，由于要照顾孩子上学，我也就辞掉了工作。做起了一个职业股民。开始了我这12年的职业生涯。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "总结这12年，我五味杂陈：有过大喜，有过大悲，有过希望，有过失望，甚至有过绝望。想起《北京人在纽约》里面的台词：“如果你爱他，就送他去纽约，因为那里是天堂；如果你恨他，就送他去纽约，因为那里是地狱。”把纽约改成股市也是很贴切的。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "如果你爱他，就送他去股市，因为那里是天堂；如果你恨他，就送他去股市，因为那里是地狱。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "但总的来说，我还是适应了这个股市。我在这里辛勤耕耘，我在这里收获成果。我在这里备受熬煎，我也在这里豁然开朗！"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "就像汪峰的歌《北京，北京》里的歌词所描绘的："
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "我在这里欢笑 　　我在这里哭泣 　　我在这里活着 　　也在这死去 　　"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "我在这里祈祷 　　我在这里迷惘 　　我在这里寻找 　　也在这儿失去"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "我当然不愿意在这里死去，我还有很多自己的事情要去做。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "我的想法是：好好做完这波行情，然后就彻底的离开股市，永远不看股票！赚到的钱分成3份：1份买信托类收益较高的产品，1份买银行的收益率低一些但无风险的产品，1份去到处旅游花掉，先国内，后世界。到处去住一阵子。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "作为职业股民，我深深地饱尝了以此为职业的个中滋味，其中的酸甜苦辣。"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "酸"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "先说酸吧，确实有时候感到很心酸："
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "首先，你跟别人相聚，你都不知道怎么介绍你自己。以前我都说自己是做股票的，结果总是留电话号码要你推荐股票，股票涨了就电话不断，是不是卖掉还是加仓，卖掉了又买什么？如此循环反复让你不胜其烦！要是你说的股票跌了也是打开了一本《十万个为什么》，甚至还落埋怨！这几年做股票的少了，同学聚会，都是教授，局长，老师什么的，到我就只好说自己做点小投资。不然你说你是做股票的人家基本上都会用一种有点怪异的眼光看着你。记得又一次老婆的同学聚会，餐桌上有人问起我的职业，老婆幽了一默：“他是个无业游民。”当时心里很不是滋味。以后好久都心戚戚兮难过！但冷静想想：不是无业游民是什么？在常人眼里你确实是个无业游民！正因为此，我在身边的朋友圈内得一绰号：富贵闲人！当然与真的富贵闲人贾宝玉没什么关系！"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "其次，一只股票你拿了很久，好不容易赚钱了，你屁颠屁颠的跑出来，赚了一点小钱，心头还沾沾自喜，结果调整完后连续的拉升，大涨了很多，你的所得相对于后面的股价微不足道，这时候确实心酸。你比如最近没多久的000062深圳华强，买进去后拿了很久，一直不涨，大半年了终于起来了，结果9.3元左右卖掉了，还得意于自己的操作。可过了没多久，2个多月吧，有个朋友从美国打来电话，问我卖掉没有，她17元多卖掉了。我心里就像打翻了醋坛子满不是滋味！"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "甜"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "甜，就很简单了。我是27万不到一点投入到股市的，那时候是我的全部家当了。经过这么多年的操作，"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "1、实现了养家糊口的目的。平时的所有开销无论大小基本上都是从股市赚来的，小的就是油盐柴米什么的日常开支，大的如孩子英国留学的费用，到处旅游的费用。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "2、买了一套别墅，另外还有2套房子，当然车子什么的不在话下。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "3、目前，股市里还有数目可观的资金。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "还有一点感到甜的是每当看到街上的小商贩在辛勤劳作的情景就会感到很幸福，我不必要像他们一样的起早贪黑日晒雨淋的劳作。当然，我没有任何瞧不起他们的意思，我也是出生于农村，很尊重各种劳动者。有时候我就在想，他就是把摊子上全部的东西卖掉也没有多少钱，干嘛不炒股呢？但转过来又一想，如果他们炒股不知道会亏成什么样子。"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "苦"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "苦呢，就三言两语说不完了，很多很多。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "首先，就是孤独感，除了孤独，还是孤独。在这个市场上，你没有朋友！你想想看，只要是一丁点腐肉，就会招来很多的苍蝇，而到今天收盘为止，A股总市值已达238601.29亿元人民币，这是多么大的利益呀！会招来多少大鳄，小偷，强盗，伪君子，骗子呀！你想一下，你的那点资金在里面只不过是沧海一黍吧。有多少巨大的力量在里面搅合，奔突呀。但对你而言他们的目的不外乎就是你那点资金而已。所以，在这里面你谁都不能依靠，只能靠你自己！only you！你决定走这条道，注定就是绵绵的孤独。从某个意义上来说，孤独就是你的宿命！"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "好像是前年吧，新浪搞了个股市二十周年的征文活动，我写了一篇短短的文章应征，我把它贴出来，与大家交流。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "一晃就是三年多了，时间过得真快！读了这篇文章，你应当对你的状况有所了解了吧。确实，你没有朋友，你只能靠你自己。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "我的QQ签名一直没有变过：投资是一个孤独的旅程！"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "如果你能容忍孤独，正视孤独进而能享受孤独，那么恭喜你，你具备了做职业股民的潜质。如果没有，那要么学会正视它，要么明智的早点离开！"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "人比较的意思，早过了争强斗胜的阶段了。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "孤独感还来源于你的操作方法越来越难与人沟通，难于被人理解了。在你与绝大多数散户一样思维的时候，你的沟通度最高，随着你自己的交易系统越来越确定，越来越细化能与你沟通的就越来越少了。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "想起当初一起做股票的朋友，到现在还在做股票的应当不到三分之一了。当初带我进股市的朋友是个急性子，股票3天不涨就会发脾气，记得他们两口子（朋友是大学教师，他老婆是中学教师）为炒股的事情不知道吵了多少次架，甚至还打过架。后来只好把账户一分为二，各炒各的，那时候我们都很少交流股票了，偶尔见面就会听到他们互相埋怨对方乱买乱卖，操作得一塌糊涂，09年两人同时销户离场。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "跟普通散户很难沟通，跟职业股民更难沟通。细细想来，我遇到的现实生活中的职业股民应当不超过3个。其中联系较多的就只有一个，我们是在“谈股论经”茶庄认识的，那时候他还在茶楼开过讲座，讲短线技术。他家住在北门，离我住的对方正好要穿城。我去过他家两次，套二的房子，客厅边上的桌子上摆着一台老旧的电脑，杂七杂八的东西乱摆着，键盘上满是烟灰，一个瘦瘦的高个子中年男人坐在那里寂寞地盯着显示屏看着k线图，这情景我是一辈子都不会忘记的，孤独寂寞的职业股民！我们一起聊得很开心。但随着交流的增多，不认同度也就越来越高了，还有印象的是他对一只股票的筑底以及底部形态的大量研究。他是纯技术派的，完全不管股票的基本面，所以聊来聊去也就相互不认同了。后来也就是在QQ上偶尔聊一下，知道他在代客理财，知道他生意不好，亏钱了被客户骂，再后来也就杳无音信了。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "说到股市的苦，当然还有亏钱的痛苦！这也是广大散户感同身受的。想想做股票以来也亏过不少钱，有多次亏钱的经历。每亏损一次就会让你感到刻骨铭心的痛楚，让你知道什么叫痛彻心扉，而不止是你听到的一句常用的歌词。大致想来，我亏钱基本上是这几种情况："
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "1、追涨杀跌。做股票的早期经常使用的手段。这个不用多说，你懂的。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "2、道听途说。相对于追涨杀跌，道听途说让我亏损更多。记得亏损最很的是3只票，一只是叫银基发展，当时有位朋友信誓旦旦的告诉我，这票要起飞，地产题材，土地增值巨大，已有大资金介入云云。当时我全仓买入，等了几个月，一直下跌，最后亏损近30万割肉出来，好痛哦，真正的切肤之痛。难怪叫割肉哦，想象一下你平时哪里有点小伤都会很痛，何况割肉哦！那时候我的资金并不是很多，不难想象对我的打击有多大，几天都没有睡好觉。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "第二只亏损严重的是南风化工，那时候有砖家说它的盐湖里面有钾，准备开采。我当时想，钾是我国最稀缺的肥料，90%以上都要靠进口，盐湖钾肥，冠农股份涨的多高哇。一旦开采不知道要涨多高哇，100元都不止。想入非非的我于是重仓杀进，守了很长时间，最后来个辟谣，该盐湖里没有钾肥，我晕死，又是一次大亏损。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "000737，现在价是3.83，我要是没有出来岂不是要要被它害死。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "还有只股票是远兴能源，一位很有来头的朋友在饭后很神秘的说的：年底一定翻番，有大煤矿注入，她已经满仓杀进！如果没有赚钱你们可以来找我。信誓旦旦的。又听进去了，结果不用说，严重亏损。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "作为职业股民的苦还体现在身体上面，你长期面对电脑，肯定会对你的身体有所损伤。比如说，头发会比较少，长期紧张与焦虑会让你掉头发。缺乏运动，如果是抽烟的朋友烟瘾会变大。另外就是你的眼睛会有影响，也就是现在所谓的“视频综合征”，眼睛比较干，容易近视什么的。我的眼睛现在如果长时间看电脑就会有点干涩，不太舒服。这也是我想现在写这个帖子的原因。我希望现在就开始写，等到这波大的行情做完，书也就顺理成章的写完，只要稍微修改一下就可以付梓了。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "这样，我也就可以永远的离开股市了，到时候也挣到了两辈子也花不完的钱了。从此，浪迹天涯，快意人生！写到这里，不知不觉就想到了黄霑的《沧海一声笑》："
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "沧海笑 滔滔两岸潮"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "浮沉随浪记今朝"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "苍天笑 纷纷世上潮"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "谁负谁胜出天知晓"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "江山笑 烟雨遥"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "涛浪淘尽红尘俗事知多少"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "清风笑 竟惹寂寥"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "豪情还剩一襟晚照"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "啦……"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "啦……"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "辣"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "辣就不用说了，早就没有辛辣，只有平和了。以前还会跟别人比一下收益什么的，比如那时候在sina的uc房间里也荐过几回股票，最好的一次是3只票当天2只涨停。随着阅历的增长觉得那些没有什么意义，不能说明什么。大概已经有6、7年不玩uc了。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "现在的心态好到什么程度呢？比方说看到我重仓的股票跌停我也一点不会急，只会耐心的看它的成交量，分析是什么原因使它跌停的。绝对不会盲目操作。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "对很大部分散户来说，要修炼的其实是他们的心态，股票一跌就慌，恨不得自己买的票今天买进去当天就大涨，明天就涨停，患有交易饥渴症，恨不得股市连礼拜六礼拜天都开门。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "一个成功的散户一定是一个心态很好的人。如果你想在股市赚到钱，那么你一定要修炼好你的心态。"
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
            title: "酸"
        }
        ListElement {
            title: "甜"
        }
        ListElement {
            title: "苦"
        }
        ListElement {
            title: "辣"
        }
        ListElement {
            title: "END"
        }
    }
}
