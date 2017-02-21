import QtQuick 2.5

Text {
    id: textItem
    width: qmlWidth(contentPanel.width)
    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
    lineHeight: 30
    font.pixelSize: 30
    font.bold: true
    color: "#2a2a2a"
    text: content
}
