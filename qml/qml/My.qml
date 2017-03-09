import QtQuick 2.5
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0

Rectangle {
    id: mainWindow

    property string apiBase: "/api"

    function getCandidates() {
        network.httpGet("../dashboarddata/metrics.json", function(res) {
            var cs = JSON.parse(res)
            for (var c in cs) {
                var d = {}
                d.selected = false

                var name = cs[c].name
                var ticker = cs[c].ticker
                var accum_volatility_50d = cs[c].accum_volatility_50d
                var relative_volatility_vs_hs300 = cs[c].relative_volatility_vs_hs300
                var avg_volume_50d = cs[c].avg_volume_50d
                var corr_vs_hs300 = cs[c].corr_vs_hs300
                d.mdata = [name, ticker, accum_volatility_50d, relative_volatility_vs_hs300, avg_volume_50d, corr_vs_hs300]

                candidatesModel.append(d)
            }
        })
    }

    function exportSelection() {
        var sel = {}
        for (var i = 0; i < candidatesModel.count; i++) {
            if (candidatesModel.get(i).selected) {
                var name = candidatesModel.get(i).mdata[0]
                var ticker = candidatesModel.get(i).mdata[1]
                sel[ticker] = name
            }
        }

        console.log(JSON.stringify(sel))
    }

    height: bgImg.height + liveChatPanel.height

    Network {
        id: network
    }

    ListModel {
        id: candidatesModel

        function getSelectedCount() {
            var count = 0
            for (var i = 0; i < candidatesModel.count; i++) {
                if (candidatesModel.get(i).selected) {
                    count++
                }
            }
            return count
        }
    }

    Column {
        anchors.fill: parent

        Image {
            id: bgImg
            width: parent.width
            height: width / 1.6
            fillMode: Image.Tile
            anchors.fill: parent
            source: "../dashboarddata/bg1.jpg"

            Rectangle {
                id: candidatesPanel

                property int itemHeight: 40

                width: {
                    if (mainWindow.width >= 1200) {
                        return 900
                    }

                    return mainWindow.width * 0.75
                }
                height: 400
                anchors.top: parent.top
                anchors.topMargin: 150
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 8

                Column {
                    anchors.fill: parent

                    Item {
                        id: titleBar
                        width: candidatesPanel.width
                        height: 40

                        Rectangle {
                            width: parent.width
                            height: 2
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "#f2f2f2"
                        }

                        Row {
                            anchors.fill: parent

                            Repeater {
                                model: ListModel {
                                    id: tModel
                                    ListElement {
                                        name: "股票名称"
                                    }
                                    ListElement {
                                        name: "股票代码"
                                    }
                                    ListElement {
                                        name: "累计波动率(50日)"
                                    }
                                    ListElement {
                                        name: "沪深300相对波动率"
                                    }
                                    ListElement {
                                        name: "平均成交量(50日)"
                                    }
                                    ListElement {
                                        name: "沪深300相关性"
                                    }
                                }
                                delegate: Item {
                                    width: titleBar.width / tModel.count
                                    height: titleBar.height

                                    Text {
                                        width: parent.width - 10
                                        anchors.top: parent.top
                                        anchors.topMargin: 10
                                        anchors.right: parent.right
                                        anchors.rightMargin: 20
                                        horizontalAlignment: Text.AlignRight
                                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                        font.pixelSize: 15
                                        font.bold: true
                                        color: "#4a4a4a"
                                        text: name
                                    }
                                }
                            }
                        }
                    }

                    ScrollView {
                        id: sView
                        width: candidatesPanel.width
                        height: candidatesPanel.height
                                - titleBar.height
                                - bottomBar.height
                        anchors.horizontalCenter: parent.horizontalCenter
                        verticalScrollBarPolicy: Qt.ScrollBarAlwaysOn
                        clip: true

                        contentItem: Item {
                            width: sView.width
                            height: candidatesPanel.itemHeight * candidatesModel.count

                            Column {
                                anchors.fill: parent

                                Repeater {
                                    model: candidatesModel
                                    delegate: Rectangle {
                                        id: cDelegate
                                        property int rowIdx: index

                                        width: sView.width
                                        height: candidatesPanel.itemHeight
                                        color: selected ? "#C1F5C4" : "transparent"

                                        Row {
                                            width: parent.width
                                            height: parent.height
                                            anchors.centerIn: parent

                                            Repeater {
                                                model: mdata
                                                delegate: Item {
                                                    width: sView.width / tModel.count
                                                    height: candidatesPanel.itemHeight

                                                    Text {
                                                        width: parent.width * 0.9
                                                        anchors.right: parent.right
                                                        anchors.rightMargin: 20
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        wrapMode: Text.WordWrap
                                                        font.pixelSize: 16
                                                        color: "#4a4a4a"
                                                        text: mdata[index]
                                                    }
                                                }
                                            }
                                        }

                                        GeneralMouseArea {
                                            onClicked: {
                                                var s = !selected
                                                candidatesModel.setProperty(cDelegate.rowIdx, "selected", s)
                                                countText.text = "已选中" + candidatesModel.getSelectedCount() + "支"
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Item {
                        id: bottomBar
                        width: candidatesPanel.width
                        height: 40

                        Rectangle {
                            width: parent.width
                            height: 2
                            anchors.top: parent.top
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "#f2f2f2"
                        }

                        Text {
                            id: countText
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 14
                            color: "#9b9b9b"
                        }

                        Text {
                            id: exportBtn
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            color: "#9b9b9b"
                            text: "导出所选股票"

                            GeneralMouseArea {
                                onEntered: {
                                    exportBtn.color = "#4a4a4a"
                                }
                                onExited: {
                                    exportBtn.color = "#9b9b9b"
                                }
                                onClicked: {
                                    mainWindow.exportSelection()
                                }
                            }
                        }

                        Text {
                            id: poweredbyText
                            anchors.right: parent.right
                            anchors.rightMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 14
                            color: "#9b9b9b"
                            text: "Powered by Gimletech"

                            GeneralMouseArea {
                                onClicked: {
                                    Qt.openUrlExternally("https://www.gimletech.com")
                                }
                            }
                        }
                    }
                }
            }
        }

        LiveChat {
            id: liveChatPanel
            width: mainWindow.width
            anchors.horizontalCenter: parent.horizontalCenter
            kf: true
            userToken: "Lenq9Wz9mUs/T6A4YtwbA+o7Tvtng141r9wg86KVxosF90Z9cYiGVACCx+leObg6932DWzGs4hZB4HaG5SwQGTRCO9/nzJHD" // moshikf
        }
    }

    Component.onCompleted: {
        getCandidates()
    }
}
