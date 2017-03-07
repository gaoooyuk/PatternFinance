import QtQuick 2.5

Item {
    id: importBox
    width: 250
    height: 150

    signal contentAvailable(var ct)

    function handleImportEvent(e) {
        contentAvailable(e.detail.message)
    }

    Image {
        anchors.fill: parent
        source: "../imgs/dashboard/iborder.png"
    }

    Text {
        width: 150
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        font.pixelSize: 14
        color: "#d8d8d8"
        text: "将您的.md文件拖拽至此进行导入"
    }

    Component.onCompleted: {
        var iptBox = document.querySelector("#embed").shadowRoot.querySelector("#importBox");
        iptBox.addEventListener('ImportMessage', handleImportEvent, false)
    }
}
