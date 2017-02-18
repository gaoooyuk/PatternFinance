import QtQuick 2.5
import QtQuick.Controls 1.4
import ChatCore 1.0

Rectangle {
    id: liveChatPanel
    width: parent.width
    height: chatPanel.height
    anchors.horizontalCenter: parent.horizontalCenter

    property string userToken: ""
    property bool connected: false
    property bool kf: false

    onUserTokenChanged: {
        client.token = userToken
        client.appKey = "4z3hlwrv4zlkt"
    }

    function timeSince(date) {
        var now = new Date()
        var seconds = Math.floor((now.getTime() - date.getTime()) / 1000);
        var interval = Math.floor(seconds / 31536000);

        if (interval >= 1) {
            return interval + "年之前";
        }
        interval = Math.floor(seconds / 2592000);
        if (interval >= 1) {
            return interval + "个月之前";
        }
        interval = Math.floor(seconds / 86400);
        if (interval >= 1) {
            return interval + "天之前";
        }
        interval = Math.floor(seconds / 3600);
        if (interval >= 1) {
            return interval + "小时之前";
        }
        interval = Math.floor(seconds / 60);
        if (interval >= 1) {
            return interval + "分钟之前";
        }

        if (seconds < 30) {
            return "刚刚"
        }

        return Math.floor(seconds) + "秒钟之前";
    }

    ChatClient {
        id: client
        onTextMessageReceived: {
            msgModel.append({ from: client.currentTargetId, msg: message, dt: (new Date).getTime() })
        }
        onImConnected: {
            liveChatPanel.connected = true
        }
    }

    Timer {
        id: tTimer
        repeat: true
        running: msgModel.count > 0
        interval: 10 * 1000 // 10s
    }

    ListModel {
        id: msgModel
    }

    Column {
        anchors.fill: parent

        Item {
            id: chatPanel
            width: parent.width
            height: 600

            Image {
                id: lcBg
                width: parent.width * 0.8
                height: parent.height * 0.8
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "../livechat/bg-pattern.png"
            }

            Image {
                id: chatDemoImg
                width: 396
                height: 524
                anchors.right: parent.right
                anchors.rightMargin: 50
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 55
                source: "../livechat/chatDemo.png"

                Column {
                    anchors.fill: parent

                    Item {
                        id: chatTitleBar
                        width: parent.width
                        height: 60

                        Rectangle {
                            width: 10
                            height: width
                            anchors.top: parent.top
                            anchors.topMargin: 26
                            anchors.left: parent.left
                            anchors.leftMargin: 16
                            radius: width / 2
                            color: liveChatPanel.connected
                                   ? "#89C33B"
                                   : "#D58B70"
                        }

                        Text {
                            anchors.top: parent.top
                            anchors.topMargin: 21
                            anchors.left: parent.left
                            anchors.leftMargin: 45
                            font.pixelSize: 15
                            font.bold: true
                            color: "#4a4a4a"
                            text: liveChatPanel.connected
                                  ? "磨石金融(在线)"
                                  : "与磨石金融连线中..."
                        }
                    }

                    ScrollView {
                        id: conversationLV

                        property int messageItemHeight: 60

                        width: parent.width - 11
                        height: 360
                        anchors.left: parent.left
                        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
                        verticalScrollBarPolicy: Qt.ScrollBarAsNeeded

                        contentItem: Item {
                            width: conversationLV.width
                            height: {
                                var h = 0
                                for (var i = 1; i < msgLayout.children.length; i++) {
                                    h += msgLayout.children[i].height
                                }

                                return h
                            }

                            Column {
                                id: msgLayout
                                anchors.fill: parent

                                Repeater {
                                    model: msgModel
                                    delegate: Item {
                                        width: conversationLV.width
                                        height: Math.max(msgText.height + timeText.height + timeText.anchors.topMargin + 15,
                                                         conversationLV.messageItemHeight)

                                        Connections {
                                            target: tTimer
                                            onTriggered: {
                                                timeText.text = timeSince(new Date(dt))
                                            }
                                        }

                                        Image {
                                            id: avatarImg
                                            width: 42
                                            height: width
                                            anchors.top: parent.top
                                            anchors.topMargin: 13
                                            anchors.left: parent.left
                                            anchors.leftMargin: 10
                                            source: "moshikf" === from
                                                    ? "../livechat/avatar.png"
                                                    : "../livechat/you.png"
                                        }

                                        Text {
                                            id: msgText
                                            width: 320
                                            anchors.top: avatarImg.top
                                            anchors.topMargin: 4
                                            anchors.left: avatarImg.right
                                            anchors.leftMargin: 5
                                            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                            lineHeight: 20
                                            font.pixelSize: 14
                                            color: "#4a4a4a"
                                            text: msg
                                        }

                                        Text {
                                            id: timeText
                                            width: 320
                                            anchors.top: msgText.bottom
                                            anchors.topMargin: 4
                                            anchors.left: msgText.left
                                            font.pixelSize: 14
                                            color: "#9b9b9b"
                                            text: timeSince(new Date(dt))
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Item {
                    id: inputPanel
                    width: parent.width
                    height: 50
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 55
                    anchors.horizontalCenter: parent.horizontalCenter

                    TextEdit {
                        id: textInput
                        width: parent.width - 40
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 30
                        font.pixelSize: 15
                        color: "#8a8a8a"
                        onEnterPressed: {
                            client.sendTextMessage(textInput.text)
                            var fm = ""
                            if (liveChatPanel.kf) {
                                fm = "moshikf"
                            }
                            msgModel.append({ from: fm, msg: textInput.text, dt: (new Date).getTime() })
                            textInput.text = ""
                        }
                    }

                    Text {
                        id: placeholder
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 12
                        font.pixelSize: 14
                        color: "#d8d8d8"
                        text: "打个招呼吧"
                        visible: 0 === textInput.text.length
                    }
                }

                Item {
                    id: fueledItem
                    width: parent.width / 2
                    height: 28
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 9
                    anchors.horizontalCenter: parent.horizontalCenter

                    GeneralMouseArea {
                        onClicked: {
                            Qt.openUrlExternally("https://www.gimletech.com")
                        }
                    }
                }
            }

            Image {
                id: chatInviteItem
                width: 400
                height: 150
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.right: chatDemoImg.left
                anchors.rightMargin: 100
                source: "../livechat/chatInvite.png"
            }
        }
    }
}
