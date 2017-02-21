import QtQuick 2.5

ArticleBase {
    id: mainWindow
    totalNumberOfChars: getTotalNumberOfChars()
    estimatedReadingMins: totalNumberOfChars/700
    totalNumberOfShares: 0
    articleId: "luhan_qinghanjijin"
    articleTitle: "鹿晗和他的清晗基金"
    articleType: "文章"
    articleCategory: "投资故事"
    authorName: "阿一西德卤"
    summary: "作为已经征服娱乐圈并且拥有众多迷弟迷妹的鹿晗，如今又要在资本圈大杀四方？故事已经开场。"
    from: "2017-02-07 20:13"
    coverImage: "../articledata/covers/luhan_qinghanjijin.png"
    contentModel: content
    tocModel: toc

    ListModel {
        id: content
        ListElement {
            type: "txt"
            ratio: 1
            content: "作为2016年已经坐拥2.7亿财富，并在中国90后富豪榜排名第5位的娱乐圈当红偶像，鹿晗与清晗基金到底能在创投圈打下多少天下？故事已经开场，磨石金融将在这里(https://www.patternfinance.com/article/luhan_qinghanjijin)持续跟踪报道。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "2017年2月6日，当看客们还在谈论特朗普的二重分身和北上广楼市的萧条时，鹿晗和他的清晗基金早已蓄势待发。凭借着娱乐圈当红小鲜肉和中国90后富豪的身份，在新希望集团官方微博发布清晗基金正式成立的消息后，迷弟迷妹们第一时间奔走相告。"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "在有颜即正义的当下，资本圈似乎也沦陷了。这支联合了新希望集团、清流资本、华视娱乐，还有鹿晗而成立的基金亦在昨天霸屏了财经头条。大佬们似乎都深谙小鲜肉和人们注意力之间那层微妙的关系。"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "刚成立便引来“投资约炮社交App”的质疑"
        }
        ListElement {
            type: "img"
            ratio: 0.89
            content: "../articledata/luhan_qinghanjijin/jiazhuangqinglv1.png"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "好的开始是成功的一半。很显然，无论是空穴来风还是有意为之，刚宣布成立不到一天的清晗基金便陷入了舆论之中，其中不乏有人拍手称快，也有人唏嘘不已。而事件的主角，便是清晗基金投资的一款社交App“假装情侣”。有媒体通过该App上一些不雅图片称清晗基金投资“色情社交”。而清晗基金发言人Amy随后也对媒体指责进行了回应。在八卦的事情上，娱乐圈和创投界似乎相当的有默契。陌陌成功的模式看来也可以被复制。毕竟，陌陌也从来是在公众面前大张旗鼓地在反对“约炮”这件事。这一切仿佛只说明了一件事: 质疑并不可怕，反正有钱赚就好。董事会和投资人估计也还没到该在意的时候，毕竟在成功引起关注这件事上，清晗基金看来已成功了一半。当资本与娱乐至死适逢其会，我们还能期望些什么呢？"
        }
        ListElement {
            type: "img"
            ratio: 0.89
            content: "../articledata/luhan_qinghanjijin/jiazhuangqinglv2.png"
        }
        ListElement {
            type: "sectionHeader"
            ratio: 1
            content: "不只是超级迷妹和偶像一起做生意"
        }
        ListElement {
            type: "txt"
            ratio: 1
            content: "创投圈的“迷妹”该是什么样？看看王梦秋就知道了。这位自称鹿晗亲妈粉的前百度副总裁，不但曾多次在社交网络表明自己是鹿晗铁粉的身份，现在还与偶像一起做起了生意。"
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
        ListElement {
            type: "txt"
            ratio: 1
            content: "未完待续"
        }
    }

    ListModel {
        id: toc
        ListElement {
            title: "质疑"
        }
        ListElement {
            title: "不只是超级迷妹和偶像"
        }
        ListElement {
            title: "END"
        }
    }
}
