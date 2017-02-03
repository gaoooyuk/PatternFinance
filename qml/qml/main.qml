import QtQuick 2.5

Rectangle {
    id: mainWindow
    width: 800
    height: 600

    Image {
        id: logoImg
        width: 48
        height: 48
        anchors.centerIn: parent
        source: "../imgs/logo.png"
    }
}
