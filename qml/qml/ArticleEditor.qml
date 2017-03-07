import QtQuick 2.5
import QtGraphicalEffects 1.0

Rectangle {
    id: mainWindow

    property alias articleTitle: titleInput.text
    property int totalNumberOfChars: 0
    property int estimatedReadingMins: 0
    property string coverImage: ""
    property var contentModel

    // impl related variables
    property int currentSelectedItemIndex: -1

    signal articleInfoChanged(var info)
    signal resetInputAsModel()
    signal focusItemRequest(int newItemIdx)

    function qmlWidth(w) {
        return w + 1
    }

    function qmlHeight(h) {
        return h + 1
    }

    function getTotalNumberOfChars() {
        var total = 0

        if (undefined !== contentModel) {
            for (var i = 0; i < contentModel.count; i++) {
                total += String(contentModel.get(i).content).length
            }
        }

        return total
    }

    function initArticleInfo(ai) {
        aeModel.setProperty(0, "value", ai.id)
        aeModel.setProperty(1, "value", ai.author)
        aeModel.setProperty(2, "value", ai.cover)
        aeModel.setProperty(3, "value", ai.lede)
        aeModel.setProperty(4, "value", ai.category)

        mainWindow.resetInputAsModel()
    }

    function updateArticleInfo() {
        var info = {}
        info.id = aeModel.get(0).value
        info.title = titleInput.text
        info.author = aeModel.get(1).value
        info.cover = aeModel.get(2).value
        info.lede = aeModel.get(3).value
        info.category = aeModel.get(4).value
        mainWindow.articleInfoChanged(info)
    }

    function addItemAtIndex(index, initStr) {
        var item = {
            "type": "txt",
            "ratio": 1,
            "content": initStr
        }
        contentModel.insert(index, item)
    }

    height: articleToolbar.height
            + articlePanel.height
            + spacer.height

    ListModel {
        id: aeModel
        ListElement {
            key: "id"
            name: "标识"
            value: ""
        }
        ListElement {
            key: "author"
            name: "作者"
            value: ""
        }
        ListElement {
            key: "cover"
            name: "封面"
            value: ""
        }
        ListElement {
            key: "lede"
            name: "导言"
            value: ""
        }
        ListElement {
            key: "category"
            name: "专栏"
            value: ""
        }
    }

    Column {
        anchors.fill: parent

        Rectangle {
            id: articleToolbar
            width: parent.width
            height: 60

            Image {
                id: adminEditImg
                width: 16
                height: 20
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: "../imgs/dashboard/gene.png"

                GeneralMouseArea {
                    onEntered: {
                        adminEditImg.source = "../imgs/dashboard/geneHover.png"
                    }
                    onExited: {
                        adminEditImg.source = "../imgs/dashboard/gene.png"
                    }
                    onClicked: {
                        adminEditPanel.visible = true
                    }
                }
            }
        }

        Rectangle {
            id: articlePanel
            width: parent.width
            height: contentPanel.height

            Rectangle {
                id: contentPanel
                width: {
                    if (articlePanel.width >= 700) {
                        return 700
                    }

                    return articlePanel.width * 0.85
                }
                height: articleTitleEditor.height + articleContentPanel.height
                anchors.horizontalCenter: parent.horizontalCenter

                Column {
                    anchors.fill: parent

                    Item {
                        id: articleTitleEditor
                        width: parent.width
                        height: Math.max(60, titleInput.height + 30)

                        Rectangle {
                            id: titleStartBar
                            width: 2
                            height: titleInput.height
                            anchors.right: parent.left
                            anchors.rightMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
                            color: "#f1f1f1"
                        }

                        Text {
                            width: 80
                            anchors.right: titleStartBar.left
                            anchors.verticalCenter: titleStartBar.verticalCenter
                            font.pixelSize: 16
                            color: "#d8d8d8"
                            text: "文章标题"
                        }

                        Text {
                            id: titleInputHolder
                            width: parent.width
                            text: titleInput.text
                            font.pixelSize: 40
                            font.bold: true
                            color: "#4a4a4a"
                            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                            visible: false
                        }

                        TextEdit {
                            id: titleInput
                            width: parent.width
                            height: Math.max(48, titleInputHolder.height)
                            font.pixelSize: 40
                            font.bold: true
                            color: "#4a4a4a"
                            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                            anchors.verticalCenter: parent.verticalCenter
                            onTextChanged: {
                                mainWindow.updateArticleInfo()
                            }
                            onEnterPressed: {
                                mainWindow.addItemAtIndex(0, "")
                            }
                        }
                    }

                    Item {
                        id: articleContentPanel
                        width: parent.width
                        height: contentLayout.height

                        Column {
                            id: contentLayout
                            spacing: 20

                            Repeater {
                                id: contentRepeater
                                model: contentModel
                                delegate: ContentEditableItem {
                                    width: contentPanel.width
                                    onInputTextChanged: {
                                        updateToolBar()
                                    }
                                    onRemoveMyself: {
                                        toolBar.visible = false
                                        contentModel.remove(index)
                                    }
                                    onAddItemBeforeRequest: {
                                        mainWindow.addItemAtIndex(index, slicedStr)
                                    }
                                    onAddItemAfterRequest: {
                                        mainWindow.addItemAtIndex(index+1, slicedStr)
                                    }
                                }

//                                delegate: Item {
//                                    id: contentDelegate
//                                    width: contentPanel.width

//                                    function loadComp() {
//                                        if ("img" === type) {
//                                            loader.source = "../qml/article/ImageComp.qml"
//                                        } else if ("txt" === type) {
//                                            loader.source = "../qml/article/TextEditComp.qml"
//                                        } else if ("sectionHeader" === type) {
//                                            loader.source = "../qml/article/SectionHeaderComp.qml"
//                                        } else if ("AD_1" === type) {
//                                            loader.source = "../qml/article/AD_1.qml"
//                                        } else if ("AD_2" === type) {
//                                            loader.source = "../qml/article/AD_2.qml"
//                                        }
//                                    }

//                                    function updateGeometry() {
//                                        var item = loader.item

//                                        if ("img" === type) {
//                                            item.source = content
//                                            item.width = qmlWidth(contentPanel.width)
//                                            contentDelegate.height = item.height
//                                            item.centerIn = contentDelegate
//                                        } else if ("txt" === type) {
//                                            item.text = content
//                                            item.width = qmlWidth(contentPanel.width)
//                                            contentDelegate.height = item.height
//                                        } else if ("sectionHeader" === type) {
//                                            item.text = content
//                                            item.width = qmlWidth(contentPanel.width)
//                                            contentDelegate.height = item.height + 50
//                                            item.anchors.bottom = contentDelegate.bottom
//                                        } else if ("AD_1" === type) {
//                                            if (mainWindow.width >= 1000) {
//                                                item.width = contentPanel.width * 1.2
//                                            } else {
//                                                item.width = qmlWidth(contentPanel.width * 0.9)
//                                            }
//                                            contentDelegate.height = item.height + 50
//                                            item.anchors.left = contentDelegate.left
//                                            item.anchors.verticalCenter = contentDelegate.verticalCenter
//                                        } else if ("AD_2" === type) {
//                                            if (mainWindow.width >= 1000) {
//                                                item.width = contentPanel.width * 1.2
//                                            } else {
//                                                item.width = qmlWidth(contentPanel.width * 0.9)
//                                            }
//                                            contentDelegate.height = item.height + 50
//                                            item.anchors.left = contentDelegate.left
//                                            item.anchors.verticalCenter = contentDelegate.verticalCenter
//                                        }
//                                    }

//                                    Connections {
//                                        target: mainWindow
//                                        onWidthChanged: {
//                                            if (loader.inited) {
//                                                contentDelegate.updateGeometry()
//                                            }
//                                        }
//                                    }

//                                    Connections {
//                                        target: articleTitleEditor
//                                        onHeightChanged: {
//                                            if (loader.inited) {
//                                                contentDelegate.updateGeometry()
//                                            }
//                                        }
//                                    }

//                                    Loader {
//                                        id: loader

//                                        property bool inited: false
//                                    }

//                                    Component.onCompleted: {
//                                        loader.loaded.connect(function () {
//                                            loader.inited = true
//                                            updateGeometry()
//                                            initEventListeners()
//                                        })

//                                        loadComp()
//                                    }
//                                }
                            }
                        }

                        Item {
                            id: toolBar
                            width: parent.width + 40
                            height: 30
                            anchors.top: parent.top
                            anchors.left: parent.left
                            anchors.leftMargin: -40
                            visible: false

                            property bool toggleOn: false

                            Rectangle {
                                id: toolBtn
                                width: 30
                                height: 30
                                radius: width / 2
                                color: toolBar.toggleOn ? "white" : "#d8d8d8"
                                border.width: toolBar.toggleOn ? 2 : 0
                                border.color: "#d8d8d8"

                                Rectangle {
                                    width: 12
                                    height: 2
                                    anchors.centerIn: parent
                                    rotation: toolBar.toggleOn ? 45 : 0
                                    color: toolBar.toggleOn ? "#d8d8d8" : "white"
                                }

                                Rectangle {
                                    width: 2
                                    height: 12
                                    anchors.centerIn: parent
                                    rotation: toolBar.toggleOn ? 45 : 0
                                    color: toolBar.toggleOn ? "#d8d8d8" : "white"
                                }

                                GeneralMouseArea {
                                    onClicked: {
                                        toolBar.toggleOn = !toolBar.toggleOn
                                    }
                                }
                            }

                            Item {
                                id: toolsPanel
                                width: parent.width - toolBtn.width - anchors.leftMargin
                                height: 30
                                anchors.left: toolBtn.right
                                anchors.leftMargin: 10
                                anchors.verticalCenter: parent.verticalCenter
                                visible: toolBar.toggleOn

                                GeneralMouseArea {
                                    cursorShape: Qt.ArrowCursor
                                }

                                Rectangle {
                                    id: addImgBtn
                                    width: 30
                                    height: 30
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                    radius: width / 2
                                    color: "#d8d8d8"

                                    GeneralMouseArea {
                                        onClicked: {
                                        }
                                    }
                                }

                                Rectangle {
                                    id: addVideoBtn
                                    width: 30
                                    height: 30
                                    anchors.left: addImgBtn.right
                                    anchors.leftMargin: 10
                                    anchors.verticalCenter: parent.verticalCenter
                                    radius: width / 2
                                    color: "#d8d8d8"

                                    GeneralMouseArea {
                                        onClicked: {
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        Item {
            id: spacer
            width: parent.width
            height: 20
        }
    }

    RectangularGlow {
          id: effect
          anchors.fill: adminEditPanel
          glowRadius: 10
          spread: 0.1
          color: "#d8d8d8"
          cornerRadius: adminEditPanel.radius + glowRadius
          visible: adminEditPanel.visible
      }

    Rectangle {
        id: adminEditPanel
        width: 300
        height: 400
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        radius: 5
        visible: false

        property string baseColor: "#52D57A"

        GeneralMouseArea {
            cursorShape: Qt.ArrowCursor
        }

        Column {
            anchors.fill: parent

            Item {
                id: adminEditTitleBar
                width: parent.width
                height: 60

                Text {
                    width: 250
                    anchors.top: parent.top
                    anchors.topMargin: 15
                    anchors.horizontalCenter: parent.horizontalCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    font.pixelSize: 20
                    color: "#4a4a4a"
                    text: "编辑文章信息"
                }
            }

            Rectangle {
                id: adminEditItems
                width: parent.width
                height: parent.height
                        - adminEditTitleBar.height
                        - adminEditBottomBar.height

                Column {
                    anchors.fill: parent

                    Repeater {
                        model: aeModel
                        delegate: Item {
                            id: aeDelegate
                            width: adminEditPanel.width
                            height: adminEditItems.height / aeModel.count

                            property bool showUpdateChange: false

                            Text {
                                width: 32
                                height: 18
                                anchors.left: parent.left
                                anchors.leftMargin: 30
                                anchors.verticalCenter: parent.verticalCenter
                                font.pixelSize: 16
                                color: "#4a4a4a"
                                text: name
                            }

                            TextInput {
                                id: valInput
                                width: 180
                                height: 18
                                anchors.top: parent.top
                                anchors.topMargin: 21
                                anchors.left: parent.left
                                anchors.leftMargin: 80
                                font.pixelSize: 16
                                color: adminEditPanel.baseColor
                                onTextChanged: {
                                    aeModel.setProperty(index, "value", text)
                                }
                            }

                            Rectangle {
                                width: valInput.width
                                height: 2
                                color: valInput.text.length > 0
                                       ? adminEditPanel.baseColor
                                       : "#f1f1f1"
                                anchors.top: valInput.bottom
                                anchors.topMargin: 2
                                anchors.left: valInput.left
                                opacity: 0.5
                            }

                            Connections {
                                target: mainWindow
                                onResetInputAsModel: {
                                    aeDelegate.showUpdateChange = false
                                    valInput.text = value
                                    aeDelegate.showUpdateChange = true
                                }
                            }

                            Component.onCompleted: {
                                valInput.text = value
                                aeDelegate.showUpdateChange = true
                            }
                        }
                    }
                }
            }

            Item {
                id: adminEditBottomBar
                width: parent.width
                height: 60

                Rectangle {
                    width: 60
                    height: 32
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    radius: width / 2
                    color: adminEditPanel.baseColor

                    Text {
                        width: 32
                        height: 18
                        anchors.top: parent.top
                        anchors.topMargin: 5
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 16
                        font.bold: true
                        color: "white"
                        text: "保存"
                    }

                    GeneralMouseArea {
                        onClicked: {
                            mainWindow.updateArticleInfo()
                            adminEditPanel.visible = false
                        }
                    }
                }

                Rectangle {
                    width: 60
                    height: 32
                    anchors.left: parent.left
                    anchors.leftMargin: 80
                    anchors.verticalCenter: parent.verticalCenter
                    radius: width / 2

                    Text {
                        width: 32
                        height: 18
                        anchors.top: parent.top
                        anchors.topMargin: 5
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 16
                        font.bold: true
                        color: "#8a8a8a"
                        text: "取消"
                    }

                    GeneralMouseArea {
                        onClicked: {
                            adminEditPanel.visible = false
                        }
                    }
                }
            }
        }
    }
}
