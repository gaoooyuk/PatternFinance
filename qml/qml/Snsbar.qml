import QtQuick 2.5

Rectangle {
    id: snsBar
    width: parent.width
    height: 30
    color: "#1a1a1a"

    Item {
        id: loginBtn
        width: 60
        height: parent.height
        anchors.right: parent.right

        Text {
            id: loginText
            height: 20
            anchors.centerIn: parent
            font.pixelSize: 14
            color: "#c8c8c8"
            text: "登录"
        }

        GeneralMouseArea {
            onEntered: {
                loginText.color = "white"
            }
            onExited: {
                loginText.color = "#c8c8c8"
            }
        }
    }

    Item {
        id: joinusBtn
        width: 60
        height: parent.height
        anchors.right: loginBtn.left

        Text {
            id: joinusText
            height: 20
            anchors.centerIn: parent
            font.pixelSize: 14
            color: "#c8c8c8"
            text: "加入我们"
        }

        GeneralMouseArea {
            onEntered: {
                joinusText.color = "white"
            }
            onExited: {
                joinusText.color = "#c8c8c8"
            }
            onClicked: {
                Qt.openUrlExternally("/joinus")
            }
        }
    }

    Item {
        id: ptBtn
        width: 85
        height: parent.height
        anchors.right: joinusBtn.left

        Text {
            id: ptText
            height: 20
            anchors.centerIn: parent
            font.pixelSize: 14
            color: "#c8c8c8"
            text: "商务合作"
        }

        GeneralMouseArea {
            onEntered: {
                ptText.color = "white"
            }
            onExited: {
                ptText.color = "#c8c8c8"
            }
            onClicked: {
                Qt.openUrlExternally("/partners")
            }
        }
    }

    Item {
        id: homeBtn
        width: 40
        height: parent.height
        anchors.right: ptBtn.left

        Text {
            id: homeText
            height: 20
            anchors.centerIn: parent
            font.pixelSize: 14
            color: "#c8c8c8"
            text: "首页"
        }

        GeneralMouseArea {
            onEntered: {
                homeText.color = "white"
            }
            onExited: {
                homeText.color = "#c8c8c8"
            }
            onClicked: {
                Qt.openUrlExternally("/")
            }
        }
    }
}
