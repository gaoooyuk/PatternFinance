import QtQuick 2.5

Rectangle {
    id: adItem
    height: 155
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter

    onWidthChanged: {
        if (width >= 700) {
            enterText1.visible = true
            enterText2.visible = false
            brTitle.width = adItem.width * 0.5
        } else {
            enterText1.visible = false
            enterText2.visible = true
            brTitle.width = (adItem.width - brImg.width) * 0.9
        }

        brAuthor.width = brTitle.width

        adItem.height = brImg.anchors.topMargin
                + Math.max(brImg.height,
                           brTitle.height + brAuthor.height + brAuthor.anchors.topMargin)
                + 10
    }

    Rectangle {
        width: parent.width
        height: 1
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#d8d8d8"
    }

    Rectangle {
        width: parent.width
        height: 1
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#d8d8d8"
    }

    Text {
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 5
        font.pixelSize: 16
        color: "#9b9b9b"
        text: "延伸阅读推荐"
    }

    Image {
        id: brImg
        width: 150
        height: 100
        anchors.top: parent.top
        anchors.topMargin: 40
        anchors.left: parent.left
        source: "../../imgs/br.png"
    }

    Text {
        id: brTitle
        anchors.top: brImg.top
        anchors.left: brImg.right
        anchors.leftMargin: 15
        font.pixelSize: 28
        font.bold: true
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        color: "#4a4a4a"
        text: "股票作手回忆录"
    }

    Text {
        id: brAuthor
        anchors.top: brTitle.bottom
        anchors.topMargin: 10
        anchors.left: brImg.right
        anchors.leftMargin: 15
        font.pixelSize: 18
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        color: "#8a8a8a"
        text: "杰西·利弗莫尔"
    }

    Text {
        id: enterText1
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 22
        color: "#8FC1E4"
        text: "去京东自营看看"
        visible: false
    }

    Text {
        id: enterText2
        anchors.top: parent.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 22
        color: "#8FC1E4"
        text: "去京东自营看看"
        visible: false

        GeneralMouseArea {
            onClicked: {
                Qt.openUrlExternally("http://blog.fens.me/meeting-iais-20161125?utm_source=patternfinance.com")
            }
        }
    }

    GeneralMouseArea {
        onClicked: {
            Qt.openUrlExternally("https://union-click.jd.com/jdc?d=XFD62t")
        }
    }
}
