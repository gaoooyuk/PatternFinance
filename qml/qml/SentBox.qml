import QtQuick 2.5
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0

Rectangle {
    id: sendingPanel
    width: parent.width
    height: 1200

    property int channelWidth: 500
    property int channelHeight: 48
    property int channelSpacing: 10

    signal newArticleRequest()

    function showResultBubble(res) {
        if (res) {
            notifyBubble.source = "../imgs/dashboard/pSuccess.png"
            notifyText.text = "已完成文章发布"
        } else {
            notifyBubble.source = "../imgs/dashboard/pFail.png"
            notifyText.text = "文章未发布成功"
        }
    }

    ListModel {
        id: cModel
        ListElement {
            channelName: "磨石金融"
            status: "已发送"
        }
        ListElement {
            channelName: "雪球"
            status: "已发送"
        }
        ListElement {
            channelName: "微信公众号"
            status: "已发送"
        }
        ListElement {
            channelName: "摩尔金融"
            status: "已发送"
        }
        ListElement {
            channelName: "凤凰号"
            status: "已发送"
        }
        ListElement {
            channelName: "百家号"
            status: "已发送"
        }
    }

    Column {
        anchors.fill: parent

        Item {
            width: parent.width
            height: 200
            clip: true

            Image {
                id: notifyBubble
                width: sendingPanel.channelWidth
                height: 48
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: notifyText
                    width: 112
                    height: 18
                    anchors.centerIn: parent
                    font.pixelSize: 16
                    color: "white"
                }
            }
        }

        Image {
            id: addNewChannelBtn
            width: sendingPanel.channelWidth
            height: sendingPanel.channelWidth * 0.12
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../imgs/dashboard/addChannel.png"

            GeneralMouseArea {
                onClicked: {
                }
            }
        }

        Item {
            width: parent.width
            height: 20
        }
    }
}
