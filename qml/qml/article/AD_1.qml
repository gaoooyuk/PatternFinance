import QtQuick 2.5

Rectangle {
    id: adItem
    height: adSpacer1.height
            + adSpacer2.height
            + adSpacer3.height
            + adSpacer4.height
            + adysText.height
            + adTitle.height
            + lyText.height
            + 2
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter

    onWidthChanged: {
        if (width >= 600) {
            enterText1.visible = true
            enterText2.visible = false
            adTitle.width = adItem.width * 0.6
        } else {
            enterText1.visible = false
            enterText2.visible = true
            adTitle.width = adItem.width * 0.9
        }

        adItem.height = adSpacer1.height
                + adSpacer2.height
                + adSpacer3.height
                + adSpacer4.height
                + adysText.height
                + adTitle.height
                + lyText.height
                + 2
    }

    Column {
        anchors.fill: parent

        Rectangle {
            width: parent.width
            height: 1
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#d8d8d8"
        }

        Item {
            id: adSpacer1
            width: parent.width
            height: 10
        }

        Text {
            id: adysText
            anchors.left: parent.left
            anchors.leftMargin: 5
            font.pixelSize: 16
            color: "#9b9b9b"
            text: "延伸阅读推荐"
        }

        Item {
            id: adSpacer2
            width: parent.width
            height: 10
        }

        Text {
            id: adTitle
            anchors.left: parent.left
            anchors.leftMargin: 10
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: {
                if (adTitle.text.length > 20) {
                    return 32
                }

                return 35
            }
            font.italic: true
            font.bold: true
            color: "#4a4a4a"
            text: "2016IAIS人工智能产业论坛: 用R语言进行投资组合管理"
        }

        Item {
            id: adSpacer3
            width: parent.width
            height: 10
        }

        Text {
            id: lyText
            width: 300
            anchors.left: parent.left
            anchors.leftMargin: 10
            font.pixelSize: 14
            color: "#8FC1E4"
            text: "来源: http://blog.fens.me/"
        }

        Item {
            id: adSpacer4
            width: parent.width
            height: 10
        }

        Rectangle {
            width: parent.width
            height: 1
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#d8d8d8"
        }
    }

    Text {
        id: enterText1
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 24
        color: "#8FC1E4"
        text: "进入文章"
        visible: false
    }

    Text {
        id: enterText2
        anchors.top: parent.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 24
        color: "#8FC1E4"
        text: "进入文章"
        visible: false

        GeneralMouseArea {
            onClicked: {
                Qt.openUrlExternally("http://blog.fens.me/meeting-iais-20161125?utm_source=patternfinance.com")
            }
        }
    }

    GeneralMouseArea {
        onClicked: {
            Qt.openUrlExternally("http://blog.fens.me/meeting-iais-20161125?utm_source=patternfinance.com")
        }
    }
}
