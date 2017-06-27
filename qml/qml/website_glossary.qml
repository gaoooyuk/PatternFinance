import QtQuick 2.5

Rectangle {
    id: mainWindow
    height: snsBar.height
            + searchPanel.height
            + mainPanel.height
            + examplePanel.height
            + copyrightBar.height

    function qmlWidth(w) {
        return w + 1
    }

    function qmlHeight(h) {
        return h + 1
    }

    function fillZXSL(arr) {
        arr.forEach(function(item) {
            zxslModel.append(item)
        })
    }

    function fillExamples(arr) {
        arr.forEach(function(item) {
            examplesModel.append(item)
        })
    }

    ListModel {
        id: zxslModel
    }

    ListModel {
        id: examplesModel
    }

    Column {
        anchors.fill: parent

        Rectangle {
            id: snsBar
            width: parent.width
            height: 50
            color: "white"

            Item {
                id: ptBtn
                width: 60
                height: parent.height
                anchors.right: parent.right
                anchors.rightMargin: 50

                Text {
                    id: ptText
                    height: 20
                    anchors.centerIn: parent
                    font.pixelSize: 14
                    color: "#4A4A4A"
                    text: "商务合作"
                }

                GeneralMouseArea {
                    onEntered: {
                        ptText.color = "#38E4BD"
                    }
                    onExited: {
                        ptText.color = "#4A4A4A"
                    }
                    onClicked: {
                        Qt.openUrlExternally("https://www.patternfinance.com/partners")
                    }
                }
            }

            Item {
                id: storyBtn
                width: 85
                height: parent.height
                anchors.right: ptBtn.left

                Text {
                    id: storyText
                    height: 20
                    anchors.centerIn: parent
                    font.pixelSize: 14
                    color: "#4A4A4A"
                    text: "投资故事"
                }

                GeneralMouseArea {
                    onEntered: {
                        storyText.color = "#38E4BD"
                    }
                    onExited: {
                        storyText.color = "#4A4A4A"
                    }
                    onClicked: {
                        Qt.openUrlExternally("https://www.patternfinance.com/story")
                    }
                }
            }

            Item {
                id: liqiBtn
                width: 40
                height: parent.height
                anchors.right: storyBtn.left

                Text {
                    id: liqiText
                    height: 20
                    anchors.centerIn: parent
                    font.pixelSize: 14
                    color: "#4A4A4A"
                    text: "利器"
                }

                GeneralMouseArea {
                    onEntered: {
                        liqiText.color = "#38E4BD"
                    }
                    onExited: {
                        liqiText.color = "#4A4A4A"
                    }
                    onClicked: {
                        Qt.openUrlExternally("https://www.patternfinance.com/liqi")
                    }
                }
            }
        }

        Rectangle {
            id: searchPanel
            width: parent.width
            height: 350
            color: "white"
        }

        Rectangle {
            id: mainPanel
            width: parent.width
            height: 350
            color: "white"

            Text {
                id: wordText
                height: 46
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 210
                font.pixelSize: 40
                font.bold: true
                color: "#4A4A4A"
            }

            Text {
                id: jsText
                width: 600
                anchors.top: wordText.bottom
                anchors.topMargin: 30
                anchors.left: wordText.left
                font.pixelSize: 20
                color: "#4A4A4A"
                wrapMode: Text.WordWrap
            }

            Text {
                id: zxslText
                height: 23
                anchors.top: jsText.top
                anchors.right: parent.right
                anchors.rightMargin: 50
                font.pixelSize: 20
                font.bold: true
                color: "#4A4A4A"
                text: "最新收录"
            }

            Item {
                id: zxslLV
                width: 400
                height: zxslLayout.height
                anchors.top: zxslText.bottom
                anchors.topMargin: 25
                anchors.right: parent.right
                anchors.rightMargin: 50

                Column {
                    id: zxslLayout
                    spacing: 15

                    Repeater {
                        model: zxslModel
                        delegate: Item {
                            id: zxslDelegate
                            width: zxslLV.width
                            height: zxslItem.height

                            Text {
                                id: zxslItem
                                anchors.right: parent.right
                                font.pixelSize: 20
                                color: "#4a4a4a"
                                text: zx
                            }

                            GeneralMouseArea {
                                onClicked: {
                                    Qt.openUrlExternally("https://glossary.patternfinance.com/" + word)
                                }
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            id: examplePanel
            width: parent.width
            height: 400
            color: "white"

            Text {
                id: yslText
                height: 23
                anchors.right: parent.right
                anchors.rightMargin: 50
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 50
                font.pixelSize: 20
                color: "#F2F2F2"
                text: "已收录"
            }

            Text {
                id: yslsText
                height: 115
                anchors.right: yslText.left
                anchors.rightMargin: 10
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 28
                font.pixelSize: 100
                color: "#F2F2F2"
            }

            Item {
                id: examplesLV
                width: 600
                height: examplesLayout.height
                anchors.left: parent.left
                anchors.leftMargin: 210
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 50

                Column {
                    id: examplesLayout
                    spacing: 25

                    Repeater {
                        model: examplesModel
                        delegate: Item {
                            id: examplesDelegate
                            width: examplesLV.width
                            height: eContentItem.height 
                                    + eSourceItem.height 
                                    + eSourceItem.anchors.topMargin

                            Text {
                                id: eContentItem
                                width: 600
                                font.pixelSize: 20
                                color: "#4a4a4a"
                                wrapMode: Text.WordWrap
                                text: content
                            }

                            Text {
                                id: eSourceItem
                                anchors.left: parent.left
                                anchors.leftMargin: -9
                                anchors.top: eContentItem.bottom
                                anchors.topMargin: 10
                                font.pixelSize: 18
                                color: "#9b9b9b"
                                text: "「" + source + "」"
                            }

                            GeneralMouseArea {
                                onClicked: {
                                }
                            }
                        }
                    }
                }
            }

            Rectangle {
                id: gLine
                width: 600
                height: 2
                anchors.left: examplesLV.left
                anchors.bottom: examplesLV.top
                anchors.bottomMargin: 25
                color: "#38E4BD"
            }

            Text {
                id: slText
                height: 23
                anchors.left: gLine.left
                anchors.bottom: gLine.top
                anchors.bottomMargin: 5
                font.pixelSize: 20
                font.bold: true
                color: "#38E4BD"
                text: "最近一次收录于"
            }
        }

        Rectangle {
            id: copyrightBar
            width: parent.width
            height: 50
            color: "white"

            Text {
                id: copyrightText
                height: 20
                anchors.centerIn: parent
                font.pixelSize: 14
                color: "#9b9b9b"
                text: "© 磨石科技"
            }
        }
    }

    Component.onCompleted: {
        try {
            var data = JSON.parse(Qt.cache)
            yslsText.text = data.total
            fillZXSL(data.zxsl)

            var cx = data.cx
            wordText.text = cx.word_zh
            jsText.text = cx.description_zh

            var examples = []
            cx.examples_zh.forEach(function(example) {
                var e = {}
                e.content = example.content.replace(cx.word_zh, "<font color=#38E4BD>" + cx.word_zh + "</font>")
                e.source = example.source
                examples.push(e)
            })
            fillExamples(examples)
        } catch(e) {
            console.log("error")
        }
    }
}
