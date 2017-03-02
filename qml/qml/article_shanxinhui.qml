import QtQuick 2.5

ArticleBase {
    id: mainWindow
    totalNumberOfChars: getTotalNumberOfChars()
    estimatedReadingMins: totalNumberOfChars/700
    totalNumberOfShares: 0
    articleId: "shanxinhui"
    articleTitle: "深度揭秘善心汇：涉及150万人！慈善掩盖下的庞氏骗局！"
    articleType: "评测"
    articleCategory: "物是评测"
    authorName: "金融防骗手册"
    summary: "善心汇究竟什么来历、是什么性质？为何那么多人涉足其中，甚至不惜与亲朋好友反目？"
    from: "2017-03-02 21:51"
    coverImage: "http://mmbiz.qpic.cn/mmbiz_jpg/tTBWF9dweQzlcXHQ3WXDOOuLdljpaNChe1RXoaWnBqdxj5Bdia1CichxZs51Dqo4ialWUqrmgWCUKOcjkasUIVshA/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1"
    contentModel: content
    tocModel: toc

    ListModel {
        id: content
        ListElement {
            type: "txt"
            ratio: 1
            content: "本文转载自微信公众号金融防骗手册(ID: jrfpsc)。经作者授权大头整理发布。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "之前在后台常常能收到很多关于“善心汇”能否投资的询问，据说很多人的七大姑八大姨都在“扶贫济困，赈灾募捐，传递善能量”的口号下投进了不少钱，也有人靠此获利颇丰，周收益率能达到50%，而且机构看起来也比较正规，隔壁的谁谁谁已经从中赚了不少，听得真是令人跃跃欲试。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "果真是如此吗？"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "高大上的“慈善互助”"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "善心汇的总公司为深圳市善心汇文化传播有限公司，该公司开发的投资平台名为“善心汇众扶互生大系统”，并自称是“为社会需要帮助的各类群体提供精神层面及物质层面的双重关怀而打造的社会和谐命运共同体的一个平台!”"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "官网严肃声称：“善心汇不是资金盘，不是互助盘，而是共生大系统!””善心汇以“扶贫济困，均富共生”的企业理念，“用自己独特的思路和思考在普度众生……”总之，企业的宗旨不是赚钱，而是扶贫，并且让当前浮躁的人群实现精神富足，致力于打开一个“美好的人类和谐画卷”!"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "善心汇官网的画风是这样的："
        }
        ListElement {
            type: "img"
            ratio: 0.42
            content: "http://mmbiz.qpic.cn/mmbiz_jpg/E8n3IicetzRJ42cZLJrl2rP100M7TsKpVvRSVer4sDYrSKGW7zzRXK3LSIdsicePcjmmg3Gx14JaJZDvfsXniaDqA/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "他的注册系统是这样的："
        }
        ListElement {
            type: "img"
            ratio: 0.48
            content: "http://mmbiz.qpic.cn/mmbiz_png/tTBWF9dweQzlcXHQ3WXDOOuLdljpaNChCSZxsJA3CejiaD4ic6bIhtPJXFyKCribZb3grwXt6ianyAUqQX4ZeQuvDg/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1"
        }
        ListElement {
            type: "img"
            ratio: 0.94
            content: "http://mmbiz.qpic.cn/mmbiz_png/tTBWF9dweQzlcXHQ3WXDOOuLdljpaNChWpfXK7WpqYPC9MDsqBTj4JaKkr5vztyZFWE6tecbFgKaudXGDGahoQ/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "是不是看起来很正规，很高大上的样子？感觉比起一般网站的五毛钱效果看起来有诚意很多。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "而对于投资人的投资收益，该公司也创立了非常“新颖”的收益形式，以“献爱心”的名义达到“会惠互利”。投资的形式主要有5种。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<strong>一是通过善心汇众扶互生大系统赚钱。</strong>"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "只要每年向公司缴纳300元年费，就可以在善心汇众扶互生大系统注册一个会员账号，激活账号后就可以选择投资方式。在该系统中，打款行为称之为“布施”，收款行为叫“受助”。收益规则如下："
        }
        ListElement {
            type: "img"
            ratio: 0.79
            content: "http://mmbiz.qpic.cn/mmbiz_png/tTBWF9dweQzlcXHQ3WXDOOuLdljpaNChZG4qM3JiaibrJzD2qgPq5XFiaDSGUpO4VSicwWp6lR83y1oUbAgde7O5lA/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<strong>每次布施前需购买善心币，价格为100元/个。</strong>贫困区排单一次需要1个善心币，小康区排单一次需要2个善心币，富人区排单一次需要3个善心币。"
        }
        ListElement {
            type: "img"
            ratio: 0.54
            content: "http://mmbiz.qpic.cn/mmbiz_png/tTBWF9dweQzlcXHQ3WXDOOuLdljpaNChLTKbc1l60JGOtRZAmc7mBUHc56DiadqdFhs6XZfDwg5KEDsy30RVlEw/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<strong>二是建立功德林，包括个人功德林、家族功德林、宗亲功德林、兄弟功德林或贵人功德林。</strong>"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "善心汇声称，家族荣誉在中华民族振兴中扮演了重要的角色，随着家族观念慢慢被冲淡，“光宗耀祖”的思想需要被传承。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<strong>三是购买善心汇文化产业集团旗下信灵房产，可以享受会员优惠价格。</strong>"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<strong>四是参加善心汇文化产业心灵禅修课程(非物质收益)。</strong>"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<strong>五是通过慈善购物平台消费与销售。</strong>在善心汇集团实体产业链的酒店，超市，景点，善心园，心灵庄园，千家福寨，心灵地产等产业按照公司规定消费。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "总之，善心汇会员不仅“可通过善心汇众扶共生大系统金融社区达到自己闲置资金的利益增长”，而且还帮助了需要帮助的人，还通过这个系统享受了相应的福利，干好事还能赚钱，真是前所未有，又有谁能拒绝这个诱惑呢？"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "铺天盖地的形象宣传"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "网上资料显示，善心汇文化产业集团主要由一家名叫深圳市善心汇的文化传播有限公司操盘。而且网上清一水的软文，无一差评，即使在“揭秘善心汇骗局”这样的标题下都是对善心汇的正面报道。<strong>该公司表示，他们根本就不是冲着钱来的。</strong>"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "“人民有信仰，民族有希望，国家有力量。”“善心汇！和天下！永远跟党走！”<strong>扶贫共生共富才是他们的目标。</strong>"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "而善心汇的项目总策划张天明，在宣传资料中，名头也很响亮。"
        }
        ListElement {
            type: "img"
            ratio: 0.76
            content: "http://mmbiz.qpic.cn/mmbiz_jpg/xSW12kqFB4RfiaZnml8RxLD02Hg6Y1TgV0RPzWzvog4Htz2gPCv4A3k3sP6y0dd6g1oQuP3BlySusjD8iaQvQdwQ/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "39项专利发明人"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "微官网科技创始人"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "品牌策划运营实践家"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "中国奋青创业盟创始人"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "无极裂变全民分销系统总设计"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "善心汇的宗旨为采用分阶、分级制度，打造一个立体化的实现共产共享，最终走向均富的社会主义理想化经济模型。<strong>而张天明的目标是带领中国人脱贫。</strong>"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<strong>而且张天明不是只说不做，自善心汇16年5月开盘以来除了节假日每天晚上准时20：30开始在群里分享自己的心得体会，还出席了很多善心活动。</strong>"
        }
        ListElement {
            type: "img"
            ratio: 0.88
            content: "http://mmbiz.qpic.cn/mmbiz_jpg/tTBWF9dweQzlcXHQ3WXDOOuLdljpaNChzLUX3ZtiaJcuAG9KeMibcdmicv09icqEK6TsricmeOBzIQ39odxOGVpr0Xw/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "辽宁锦州北镇市罗罗堡镇千家福寨旅游风景区幸福乡村示范园区启动仪式"
        }
        ListElement {
            type: "img"
            ratio: 0.55
            content: "http://mmbiz.qpic.cn/mmbiz_jpg/tTBWF9dweQzlcXHQ3WXDOOuLdljpaNChqXniaAI57iaMszqs9legShIHMFp15tbibqFfvZE2afib5b6vC86CYlKKaw/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "善心汇幸福乡村示范园-千家福寨"
        }
        ListElement {
            type: "img"
            ratio: 0.65
            content: "http://mmbiz.qpic.cn/mmbiz_jpg/tTBWF9dweQzlcXHQ3WXDOOuLdljpaNChzUkTzictUXum7VjKTflgibfUkbMdGUsn8KC3Z51zP0gBb29icmic4A8sdg/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "善心汇将旗下种植基地的黄花梨树苗称作“善心树”，作为家族的象征，种在“至善同明--宗亲林”里，励志承接中国民族的族谱及家族荣誉感的再造工程！"
        }
        ListElement {
            type: "img"
            ratio: 0.83
            content: "http://mmbiz.qpic.cn/mmbiz_jpg/xSW12kqFB4RfiaZnml8RxLD02Hg6Y1TgVKKq5ufrPmzJRKhTJeS9tG8yR87O5ugCZxyuwNn6RAhHEGy9ZY6ASCw/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "1月9日，善心汇甚至向一个名叫中国妇女发展基金会的机构，捐赠了1000万元。就在1月10日这天，这一报道登陆央视中文国际频道。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "如此铺天盖地的宣传，实实在在的“示范园”、“宗亲林”，确确实实的央视报道，换成是你，你信吗？"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "撕去慈善外衣，就是庞氏骗局"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "这样实力雄厚，只行善事，还有央视报道的善心汇，难道不值得信任，不值得投资，不值得参与发展吗？为何还有人说这是一个资金盘，是一个庞氏骗局呢？"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "如何辨别一个投资平台是旁氏骗局和传销?"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "传销最主要的特征是，组织需要被发展人员发展其他人员加入来盈利，这些人员形成上下线关系，并以下线的销售业绩为依据计算和给付上线报酬，牟取非法利益。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "庞氏骗局是一人为主导，其余人均为下线，传销可以说是庞氏骗局的高级衍生，有更高的迷惑性。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "善心汇共生系统推广制度鼓励发展下线拿提成的模式非常符合传销的发展形式。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "在善心汇所谓的动态激励阶梯收益中，第一代、第三代和第五代可以分别拿到6%、4%和2%的提成。善心汇声称，这种奖励模式是史上首推1.3.5代领导奖，独有跳级制，杜绝架空领导人。然而，这只是一种变相的发展下线的方式而已。"
        }
        ListElement {
            type: "img"
            ratio: 0.30
            content: "http://mmbiz.qpic.cn/mmbiz_jpg/E8n3IicetzRJ42cZLJrl2rP100M7TsKpVIyZvVa0CgSFFHQXKATBqNsqpsvVBSP2bIdLXMNhgT1M9aKwbicFAxlw/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "善心汇在推广自己的APP时，声称“只要你邀请更多的用户注册就会获得丰厚的回报”。平台通过“介绍方”拉人入伙获得投资资金以外，还通过购买善心币和会员年费等方式变相收费，说白了就是“靠人头获利”。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "其次，辨别一个平台是否是投资骗局，可以看它是否提供了过高的收益。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "虽然随着投资额的增加收益率越来越低，但这只是为了营造一种“我不是旁氏骗局”的假象，持有闲散资金几百万的投资者通常不会选择这样的投资平台，该平台的集资目标主要面向于前两个等级的用户，即被30%和50%的收益率所吸引的投资者。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "善心汇的收益明显已经超出了正常投资收益的范围。在介绍自己的盈利模式时，善心汇自称有实业做背景，通过投资实业获得盈利。但是，在当前的经济态势下，发展再好的实业也不会每月达到30%的利润。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "最后，资金流向成谜，新进会员的钱流向的是老会员的收益。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "当被问及是否知道自己的资金去向时，其中的会员称，匹配的人各种各样，由系统提供打款对方电话和账号资料，其中穷人和残疾人都有，对于如何确定对方为这些群体，表示这些信息都源于善心汇老总张天明，善心汇有着自己的微信会员群，而在这里，每晚8点，张天明都会对这些会员进行“培训”，也就是说所有的匹配对象都是无法确定的，而这种模式则像极了当年的庞式骗局，所谓的匹配对象不过是将新用户的钱用于支付了老用户的利息和短期回报。"
        }
        ListElement {
            type: "img"
            ratio: 0.89
            content: "http://mmbiz.qpic.cn/mmbiz_jpg/E8n3IicetzRLx96GdezajJWaBTCNDg21aszpia9xkdolgDRxvNUXOoicVOg0QoxweCoPwEvQ9rFsARDmkL2Cmbngg/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "据此前媒体报道，在善心汇的微信群中，群主每天都会催促群内成员发展新会员，其中，不少群成员之间的关系多为亲属或者朋友。目前，“善心汇”已经存在资金量严重不足的问题。所以只能加快匹配速度，通过不断发展下家，进行吸金。"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "是系统升级还是崩盘的前兆?"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "然而正是这样一个如此高大上的平台却在今年春节期间开始无法实现回款，据一会员称，善心汇从年前便开始系统升级，截止到目前为止，已经有一个多月无法收到回款，对此，涉及人员表示确有其事，但他也说明善心汇老总张天明已经向会员承诺，系统将会在3月份恢复正常。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "然而，无法回款真的只是系统升级的原因造成的吗？3月即将到来，善心汇的系统真的能恢复正常吗？目前尚不得而知。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "但通过以往类似平台的现象来看，一旦出现此类情况，那么这或将意味着系统极有可能面临着崩盘的危险，而所谓的总裁也不过是想趁机并以此为借口，大捞一笔，然后逃之夭夭，此类案件比比皆是。"
        }
        ListElement {
            type: "img"
            ratio: 0.90
            content: "http://mmbiz.qpic.cn/mmbiz_jpg/E8n3IicetzRLx96GdezajJWaBTCNDg21akEiaMibeZHtUNN9a2RlDF1wibpYarEfPv2nHf2CbdKwlop3Gial5clSO9g/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "另外，当下虽然系统仍在升级状态中，无法进行回款，但依旧可以进行注册并成为其中的会员，而也正是这种只进不出的现象，更加让外界的人难以理解，并加剧了善心汇就是庞式骗局的猜测。据了解，目前善心汇已有150万会员，500多名员工，也就是说，一旦善心汇出现崩盘，那么将有150万人将面临血本无归的局面。"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "入局的人是清醒还是被洗脑?"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "该公司表示，善心汇众扶互生大系统的会员可以免费参加善心汇文化产业心灵禅修课程，从而实现“让心能量不断的增长，未来的信仰与敬畏，走心长征路，拂去心灵的尘埃，打造心境界。”"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "目前来看，该平台将奉献爱心作为教育投资者的手段，并将重点发展对象定位在了广大的农村地区。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "相较于城市地区，农村人民的防诈骗意识更弱一些，也更容易被这些诈骗行为披着的漂亮外衣所迷惑。善心汇利用人们行善的心里，到处去做“爱心活动”，对投资者一遍又一遍的进行洗脑，导致不明所以的受害者将身边的人也拉入了陷阱。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "如果一个投资平台没有向你强调投资风险，那你投资的一定是假平台。然而，更让人痛心的是，有些人明明知道这是投资骗局，依然愿意参与其中，而最主要的驱动力就是贪婪之心。旁氏骗局一般都会通过高利润来激起投资者的贪婪之心，短时间内的获利则消除了你的戒备心。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "END"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "<strong>插播大头招聘广告一条</strong> <br>如果你对某个金融产品不吐不快，或者想成为“物是评测”的专栏作者，现在就联系我吧: datou@patternfinance.com"
        }
    }

    ListModel {
        id: toc
        ListElement {
            title: "高大上的“慈善互助”"
        }
        ListElement {
            title: "铺天盖地的形象宣传"
        }
        ListElement {
            title: "撕去慈善外衣，就是庞氏骗局"
        }
        ListElement {
            title: "是系统升级还是崩盘的前兆?"
        }
        ListElement {
            title: "入局的人是清醒还是被洗脑?"
        }
        ListElement {
            title: "END"
        }
    }
}
