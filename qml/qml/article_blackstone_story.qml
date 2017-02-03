import QtQuick 2.5
import "./Sidebar.qml"
import "./Sharebar.qml"

Rectangle {
    id: mainWindow

    Column {
        anchors.fill: parent

        Item {
            width: mainWindow.width
            height: mainWindow.height - morePanel.height

            Row {
                anchors.fill: parent

                Rectangle {
                    id: reader

                    property int lMargin: 110
                    property int lineWidth: 620

                    width: Math.max(600, parent.width - sideBar.width)
                    height: parent.height

                    Rectangle {
                        id: contentArea
                        width: 800
                        height: coverImg.height
                                + titleBar.height
                                + articleSummaryPanel.height
                                + articleContent.height
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
                                source: "http://payload43.cargocollective.com/1/6/220736/3173056/BLKX_06_1000.jpg"
                            }

                            Item {
                                id: titleBar
                                width: parent.width
                                height: 150

                                Rectangle {
                                    anchors.fill: parent
                                    color: "black"
                                    opacity: 0.8
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
                                    anchors.topMargin: 0
                                    font.pixelSize: 16
                                    color: "white"
                                    text: "阿一西德卤 | 2017-01-28 19:45"
                                }

                                Text {
                                    id: articleTitleText
                                    width: 700
                                    anchors.left: parent.left
                                    anchors.leftMargin: 30
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 20
                                    font.pixelSize: 30
                                    lineHeight: 40
                                    wrapMode: Text.WordWrap
                                    color: "white"
                                    text: "黑石帝国的崛起: 华尔街赚钱大王"
                                }

                                Image {
                                    id: dashlineImg
                                    width: parent.width - 60
                                    anchors.left: parent.left
                                    anchors.leftMargin: 30
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 80
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
                                        text: "编者按：根据新思路金融2017年1月25日发布在公众号的一文改编。主要补充了2008年金融危机后的内容，并在其他段落增加了一些图文说明。原文链接 http://mp.weixin.qq.com/s/k_hxxe-BFnuvTeidwnQUng"
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
                                height: 12000

                                Column {
                                    anchors.fill: parent
                                    spacing: 40

                                    Repeater {
                                        model: ListModel {
                                            ListElement {
                                                content: "美国纽交所的数据显示，黑石集团过去5年年均利润超过10亿美元，2006年一年盈利就高达22.7亿美元，年增长率为71%。如果以该盈利计算，黑石集团每位员工为公司赚了295万美元，是华尔街最赚钱的投资银行——高盛集团的9倍，黑石成为华尔街最能赚钱的公司。日前黑石上市了，是私募股权基金中将主体公司上市的第一家。 "
                                            }
                                            ListElement {
                                                content: "从坚决不做敌意收购，到首开先河成为公众公司，黑石从来都是最与众不同的那一个。"
                                            }
                                            ListElement {
                                                content: "在华尔街，有两个如雷贯耳的名字，皮特•彼得森和史蒂夫•施瓦茨曼。他们是黑石集团的共同创始人，现年81岁的彼得森担任集团的高级主席，60岁的施瓦茨曼则出任主席和CEO。黑石之所以如此成功，可以说是两位元老各自禀赋的完美结合，华尔街的人比喻说，年富力强的施瓦茨曼坚韧不拔的毅力和充沛的精力是黑石这部庞大“生财机器”得以顺利运转的“发动机”，老谋深算的彼得森在政界及金融界游刃有余的外交手腕和深厚的人脉资源则是黑石的“润滑剂”。"
                                            }
                                            ListElement {
                                                content: "1、黑石成立之初：首战大捷，奠定口碑（1985-1990）"
                                            }
                                            ListElement {
                                                content: "黑石于1985年诞生，当时并购业务在美国已经开展的如火如荼。由KKR公司主导的乌达耶收购案掀开了行业爆炸式迅猛发展的序幕，它自身也由此成为行业内的领军人物。当时，私募股权业以一种全新的融资方式（垃圾债券）为自身募集了大量的资金进行杠杆收购；他们通常在恶意并购目标公司之后，采用资产剥离、大规模裁员或其他重组活动攥取利润，从而有了一个不好的称谓—“掠夺公司”。"
                                            }
                                            ListElement {
                                                content: "黑石创立之初只有40万美元的启动资金，凭借创始人的声誉以及努力，在1987年10月募集了6亿美元，并开始了并购之旅。"
                                            }
                                            ListElement {
                                                content: "黑石的第一个收购案例是运输之星公司。当时美国钢铁集团正与著名的恶意收购方卡尔•依坎周旋，后者已发出恶意收购要约。美国钢铁集团为保住公司核心资产，找到黑石寻求帮助；黑石引入了化学银行为之提供贷款。美国钢铁集团和黑石集团共同出资设立了子公司—运输之星控股有限公司，同时将美国钢铁的核心资产转移至新成立的子公司。黑石于1986年介入该项目，到2003年完全卖出股权时，黑石及其投资者获得了25倍收益，15年间的年平均收益率达130%。具体交易细节如下所示："
                                            }
                                            ListElement {
                                                content: "在此次交易过程中，黑石确定了其投资风格，同时奠定了良好的行业口碑。"
                                            }
                                            ListElement {
                                                content: "运输之星大捷之后，黑石也遭遇了一系列挫折，如埃德加康博公司收购案布莱恩•麦克维的资本套利业务等，黑石也因此调整了投资策略，及时建立了投资审查制度。虽然这并不能完全避免失败，但其保证了黑石在经历了资本市场风浪之后，还能生存下来并发展壮大。"
                                            }
                                            ListElement {
                                                content: "此外，黑石开始进军其他业务领域。如1988年黑石成立了黑石财务管理集团，从事抵押证券和其他固定收益证券投资。"
                                            }
                                            ListElement {
                                                content: "2、从频临死亡到行业翘楚的涅槃（1990年代）"
                                            }
                                            ListElement {
                                                content: "1989年至1992年，三年经济低谷，信贷市场停滞，私募股权公司需尽全力才能使旗下债台高筑的公司生存下来。在此期间，因黑石集团几次投资失利，将其置于频临死亡的境地；然而黑石集团通过迅速调整，与凯雷等几家公司共同成为私募股权领域的领导者，结束了80年代KKR一家独大的局面。"
                                            }
                                            ListElement {
                                                content: "伴随着此次金融危机，市场发生了一定变化：整体价值小于分拆价值的公司越来越少；收购公司自身需提供的并购资金由80年代的5%-10%，上升至30%左右，甚至更高。因此收购公司不能仅靠简单的“收购—分拆”模式赚钱，而需进一步关注“公司创造价值的能力”。"
                                            }
                                            ListElement {
                                                content: "■适时开辟不动产业务，把握横财"
                                            }
                                            ListElement {
                                                content: "在杠杆收购业务如履薄冰的时候，黑石集团趁机丰富业务种类，不动产基金、FOF、夹层基金都是90年代新增的业务，后为黑石获取了丰富的回报。同时，黑石集团成为第一个进行不动产风险投资的私募股权公司，并且成为该领域的专家。随着80年代资产泡沫的破灭，不动产商和银行在困境中挣扎，而行业低谷也正预示巨大的投资机会。此期间，黑石在不动产领域的部分投资如下："
                                            }
                                            ListElement {
                                                content: "■科技泡沫时代巨大收获与阵痛"
                                            }
                                            ListElement {
                                                content: "1995年4月，网景公司IPO，这可看作资本市场的一个转折点，代表着互联网时代的来临。风险投资取代杠杆收购业务，成为市场新的追逐点：公司的财务报表不再重要，未来潜在的巨额利润才是吸引投资者注意的兴奋点。黑石在通讯领域做出的成功投资有5个，数量不多却获利颇丰，总共赚取了150亿美元的利润。这些被投资的公司基本都在农村地区开展业务，收益稳定。"
                                            }
                                            ListElement {
                                                content: "90年代末期，随着互联网泡沫破裂，许多公司遭遇了巨大的损失，黑石集团也不能幸免；但由于黑石看到了危机，后期没有深入介入互联网行业，损失的规模低于同行。"
                                            }
                                            ListElement {
                                                content: "3、秃鹰基金：度过萧条期的替代工具（2000年初）"
                                            }
                                            ListElement {
                                                content: "2000年至2002年，股票市场持续下跌，几乎没有杠杆收购的投资机会。黑石集团不得不调整方向进入了秃鹰债务投资领域。在该领域获取成功，需要熟稔所投资的行业、公司及破产程序，还需良好的运气。庆幸的是，黑石赢了。此期间，黑石的部分投资如下："
                                            }
                                            ListElement {
                                                content: "这两项投资合计5.16亿美元，收获近10亿美元的利润，所获收益加起来约为黑石投资于问题债券的两倍。"
                                            }
                                            ListElement {
                                                content: "特别是2002年，黑石通过分析认为，已经遇到了10年难遇的低价收购资产的机会。当2003年经济企稳并开始反弹时，黑石的交易额达165亿美元，远远领先于对手，夺得了先机。"
                                            }
                                            ListElement {
                                                content: "4、并购浪潮：黄金时期的大发展（2003-2007）"
                                            }
                                            ListElement {
                                                content: "■市场回暖，资金泛滥——证券化助推过度繁荣"
                                            }
                                            ListElement {
                                                content: "这一期间是私募股权业得以快速发展的黄金时机，黑石在此期间完成了很多大手笔操作。而伴随黑石2007年的上市，将这一时期的疯狂推向了高潮。如同80年代垃圾债券对私募股权业的影响，此时出现了债券市场的创新—资产证券化，也称为结构性融资。银行利用该工具募集大量资金提供给私募股权业用于收购项目。愈演愈烈的资金泛滥状况，不断刷新着单笔投资额记录，投资标的也转变为上市公司。黑石在此期间的部分投资案例如下所示："
                                            }
                                            ListElement {
                                                content: "■塞拉尼斯案例——精巧的时机，运营的改善，最成功的交易"
                                            }
                                            ListElement {
                                                content: "塞拉尼斯（简称塞）虽是德国公司，但只约有20%的业务及利润来自德国，其余均来自美国。因此德国股票市场并未给予其足够关注，如果提高运营效率并在美国上市，该公司是一个理想的收购标的。事实上，至2007年5月末股份出售后，投资利润合计29亿美元，达投资成本的5倍。然而整个过程并非一帆风顺，黑石集团的应对方案及重组过程很好地展现了其专业性。"
                                            }
                                            ListElement {
                                                content: "收购前遇到的几个方面的挑战如下所示："
                                            }
                                            ListElement {
                                                content: "在应对以上四个方面挑战的同时，黑石也在着手其重组计划，主要集中在公司文化、运营管理、生产效率及业务构成四个方面，如下图："
                                            }
                                            ListElement {
                                                content: "塞的成功归因于三方面：行业周期性上扬、公司股价在美国的高倍数增长、运营方面的变革，而前两方面大概贡献了总利润的2/3。因此，无论何时，时机是最为重要的。"
                                            }
                                            ListElement {
                                                content: "■办公物业投资信托——踩准市场节奏，跻身顶级交易之列"
                                            }
                                            ListElement {
                                                content: "2004年3月起的两年间，黑石集团已经在美国购买了11家公开上市的不动产投资信托公司（REITS），以及一连串连锁酒店：美国公寓式酒店、第一医疗、温德姆国际酒店、拉昆塔和玛丽之星酒店。2006年，黑石集团不动产团队开始把投资方向聚焦于写字楼，他们以56亿美元收购了美利加不动产公司，并以18亿美元的价格拥有了崔泽克地产公司大部分资产。在此期间，黑石最成功的投资案例莫过于投资办公物业投资信托公司（Equity Office Properties，EOP）。"
                                            }
                                            ListElement {
                                                content: "2007年正值美国写字楼价格持续上涨、整个不动产市场回报率不断下降的阶段。黑石的这项投资其实风险很大，2007年夏季爆发的次贷危机也验证了该风险的客观存在。然而，黑石不仅拥有独到的眼光，还拥有将资产闪电剥离的手段，促成了又一经典之作。"
                                            }
                                            ListElement {
                                                content: "EOP拥有很多地产，但很多位于非核心地带，因此公司总价值相对较低。黑石集团计划全部买入，然后变卖掉公司1/3左右的资产，这样就可以低成本廉价拥有剩下的资产，即采用“整体收购”而后“分拆出售”的投资方法。黑石对于EOP所持有的4个核心市场的地产梦寐以求——纽约、波士顿、西洛杉矶以及旧金山海湾地区。"
                                            }
                                            ListElement {
                                                content: "谈判过程并非一帆风顺，半路杀出了另一个竞争对手-不动产信托基金沃那多，其与黑石竞价耗时3个月，过程如下："
                                            }
                                            ListElement {
                                                content: "融资过程中，黑石集团只用了5天时间就从贝尔斯登、美国银行以及高盛那里融到了295亿美元的资金。除了贷款给黑石外，这些银行还投资了几十亿美元购买办公物业投资信托公司的部分股权，而黑石集团将在卖掉办公物业投资信托公司资产之后以稍高的溢价赎回。黑石集团通过为不动产基金融资，共投入35亿美元。"
                                            }
                                            ListElement {
                                                content: "大量商业地产公司希望买下该公司的部分物业，黑石看到了通过分拆变卖资产来为收购融资的可能性。曲折的谈判过程推高了总收购价格，经过分析，黑石必须卖掉比他们之前计划的1/3还要多的多的资产。卖出的部分房产如下："
                                            }
                                            ListElement {
                                                content: "事实上，交易结束仅一周，黑石就卖掉了53座大楼，成功套现146亿美元。2月到6月之间，黑石集团分拆出售了EOP大约930万平方米中的567万平方米，得到了280亿美元，仅留下在最黄金市场中的地产。这些分拆销售的价格都很高，因此其成本远低于其市场价值。销售全部结束后，黑石集团35亿美元的股权投资增值为70亿美元，账面上赚了35亿美元。仅仅通过分拆EOP，黑石集团就已经使自己的账面资金翻了一番。若非迅速剥离资产，“次贷危机”将对黑石产生重大不利影响。"
                                            }
                                            ListElement {
                                                content: "5、2008年金融危机之后：应对方式及其亚洲策略"
                                            }
                                            ListElement {
                                                content: "金融危机后，黑石短期内投资收益、投资项目也逐步减少。公司的股价表现也很糟糕，2009年2月，黑石集团的股价跌到了3.55美元，相对于上市时的峰值，至少缩水了90%。但是公司在业务上的进展还是比许多竞争者顺利，危机爆发后3年内，黑石集团持有的公司中仅有一家破产；此外还有多家公司在困境中，然而当时能够让企业生存下去已经是了不起的胜利。在金融危机前，黑石为每一笔交易都支付了相对较高的对价，而信贷市场危机使得这些交易需要再融资，黑石不得不与债权人谈判，减少或者延缓债务，从而度过危机并寻找新的投资机会。"
                                            }
                                            ListElement {
                                                content: "金融危机后黑石集团加大了对新兴市场的投资，在亚洲市场尤其是中国逐步加快了投资速度。为进入中国市场，黑石力邀前香港财政司司长梁锦松加入黑石。梁锦松走马上任后就为黑石募资30亿美元，并且采用了“走上层路线”的策略，便于拓展中国市场。因此，不同于凯雷等对手在中国的水土不服，黑石的中国之旅比较顺利，这也印证了黑石的投资智慧。黑石在中国的投资包括蓝星集团、寿光物流园等，成功退出的项目收益情况也较令人满意。2008年，黑石集团购入上海Channel1购物中心的物业，价格为10亿元，总面积为4.2万平方米。在持有该物业的三年时间内，黑石集团将其出租率提高至90%。2011年9月，黑石集团将所持有的Channel195%的股权出售给新世界发展有限公司，价格为14.6亿元人民币。"
                                            }
                                            ListElement {
                                                content: "END"
                                            }
                                        }

                                        delegate: Item {
                                            width: articleContent.width
                                            height: textItem.height

                                            Text {
                                                id: textItem
                                                width: reader.lineWidth
                                                height: textItem.paintedHeight
                                                anchors.left: parent.left
                                                anchors.leftMargin: reader.lMargin
                                                wrapMode: Text.WordWrap
                                                lineHeight: 30
                                                font.pixelSize: 16
                                                color: "#4a4a4a"
                                                text: content
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        Sharebar {
                            id: shareBar
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            y: coverImg.height
                               + titleBar.height
                               + sPanel.anchors.topMargin
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

        Item {
            id: morePanel
            width: mainWindow.width
            height: 1180

            Image {
                id: moreBg
                anchors.fill: parent
                fillMode: Image.Tile
                source: "http://www.mckinsey.com/redesign/resources/images/interlaced-gray-bg.png"
            }
        }
    }
}
