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
    property string publishStatus: "public" // private, draft, public

    signal articleInfoChanged(var info)
    signal resetInputAsModel()
    signal focusItemRequest(int newItemIdx, string pcp) // pcp: prefered caret position
    signal importArticleRequest(string url)

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
        // console.log("initArticleInfo: ", ai)
        aeModel.setProperty(0, "value", ai.id)
        aeModel.setProperty(1, "value", ai.author)
        if ("" !== ai.cover) {
            aeModel.setProperty(2, "value", ai.cover)
        }
        aeModel.setProperty(3, "value", ai.lede)
        if ("" !== ai.category) {
            aeModel.setProperty(4, "value", ai.category)
        }
        mainWindow.resetInputAsModel()
    }

    function importArticle(article) {
        initArticleInfo(article)
        titleInput.text = article.title
        var contentArray = JSON.parse(article.rawData)
        if (contentModel) {
            contentModel.clear()
            for (var i in contentArray) {
                contentModel.append(contentArray[i])
            }
        }
    }

    function updateArticleInfo() {
        var info = {}
        info.id = aeModel.get(0).value
        info.title = titleInput.text
        info.author = aeModel.get(1).value
        info.cover = aeModel.get(2).value
        info.lede = aeModel.get(3).value
        info.category = aeModel.get(4).value
        info.status = mainWindow.publishStatus
        mainWindow.articleInfoChanged(info)
    }

    function addItemAtIndex(index, initStr) {
        console.log("addItemAtIndex: ", index)
        var item = {
            "type": "txt",
            "ratio": 1,
            "content": initStr
        }
        contentModel.insert(index, item)
        setTimeout(function() {
            mainWindow.focusItemRequest(index, "start")
        }, 50)
    }

    function setItemType(index, type) {
        if (index >= 0 && contentModel.count >= index) {
            contentModel.setProperty(currentSelectedItemIndex, "type", type)
        }
    }

    height: articleToolbar.height
            + articlePanel.height
            + spacer.height

    Timer {
        id: autoSaver
        interval: 1000 * 5 // 5s
        running: true
        onTriggered: {
            // TODO: auto save article
        }
    }

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

            Text {
                id: cloneBtn
                width: 28
                height: 16
                anchors.right: metaBtn.left
                anchors.rightMargin: 25
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14
                color: "#9b9b9b"
                text: "采集"

                GeneralMouseArea {
                    onClicked: {
                        metaEditPanel.visible = false
                        cloneBar.visible = !cloneBar.visible
                    }
                }
            }

            Text {
                id: metaBtn
                width: 60
                height: 16
                anchors.right: visibilityCombo.left
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14
                color: "#9b9b9b"
                text: "编辑Meta"

                GeneralMouseArea {
                    onClicked: {
                        cloneBar.visible = false
                        metaEditPanel.visible = !metaEditPanel.visible
                    }
                }
            }

            Item {
                id: visibilityCombo
                width: 40
                height: 40
                anchors.right: contentPanel.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter

                Text {
                    id: visibilityText
                    width: 28
                    height: 16
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 14
                    color: "#9b9b9b"
                    text: "private" === mainWindow.publishStatus
                          ? "私有"
                          : "draft" === mainWindow.publishStatus
                            ? "草稿"
                            : "公开"

                    GeneralMouseArea {
                        onClicked: {
                            if ("private" === mainWindow.publishStatus) {
                                mainWindow.publishStatus = "draft"
                            } else if ("draft" === mainWindow.publishStatus) {
                                mainWindow.publishStatus = "public"
                            } else {
                                mainWindow.publishStatus = "private"
                            }
                            mainWindow.updateArticleInfo()
                        }
                    }

                    Component.onCompleted: {
                        var css = visibilityText.dom.firstChild.style
                        css.borderBottom = "2px dotted #d8d8d8"
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
                                console.log("titleInput onEnterPressed")
                                mainWindow.addItemAtIndex(0, "")
                            }
                        }
                    }

                    Item {
                        id: articleContentPanel
                        width: parent.width
                        height: Math.max(600, contentLayout.height)

                        Column {
                            id: contentLayout
                            spacing: 20

                            Repeater {
                                id: contentRepeater
                                model: contentModel
                                delegate: ContentEditableItem {
                                    width: contentPanel.width
                                    onItemSelected: {
                                        currentSelectedItemIndex = index
                                        updateToolBar()
                                    }
                                    onInputTextChanged: {
                                        contentModel.setProperty(index, "content", input.dom.innerHTML)
                                        updateToolBar()
                                    }
                                    onRemoveMyself: {
                                        toolBar.visible = false
                                        contentModel.remove(index)
                                        if (0 !== index) {
                                            setTimeout(function() {
                                                mainWindow.focusItemRequest(index-1, "end")
                                            }, 50)
                                        } else {
                                            titleInput.dom.firstChild.focus()
                                        }
                                    }
                                    onAddItemRequest: {
                                        mainWindow.addItemAtIndex(index+1, slicedStr)
                                    }
                                }
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

                            function close() {
                                toolBar.toggleOn = false
                                toolBar.visible = false
                            }

                            function updatePlaceholder(type) {
                                if ("txt" === type) {
                                    placeholderText.text = "开始编辑文章"
                                } else if ("sectionHeader" === type) {
                                    placeholderText.text = "插入段落标题"
                                } else if ("img" === type) {
                                    placeholderText.text = "输入url后按回车键Enter载入图片"
                                }
                            }

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
                                id: toolPlaceholderPanel
                                width: 300
                                height: 39
                                anchors.left: toolBtn.right
                                anchors.leftMargin: 10
                                anchors.verticalCenter: parent.verticalCenter
                                visible: !toolBar.toggleOn

                                Text {
                                    id: placeholderText
                                    width: 300
                                    height: 18
                                    anchors.top: parent.top
                                    anchors.topMargin: 8
                                    anchors.left: parent.left
                                    font.pixelSize: 16
                                    color: "#d8d8d8"
                                    text: "1234567890"
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
                                    border.width: 2
                                    border.color: "#d8d8d8"

                                    Image {
                                        id: imgBtn
                                        width: 16
                                        height: 12
                                        anchors.centerIn: parent
                                        source: "../imgs/dashboard/addImage.png"
                                    }

                                    GeneralMouseArea {
                                        onClicked: {
                                            // close toolBar before doing other things
                                            toolBar.close()

                                            setItemType(currentSelectedItemIndex, "img")
                                            focusItemRequest(currentSelectedItemIndex, "start")
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
                                    border.width: 2
                                    border.color: "#d8d8d8"

                                    Image {
                                        id: videoBtn
                                        width: 12
                                        height: 15
                                        anchors.top: parent.top
                                        anchors.topMargin: 8
                                        anchors.left: parent.left
                                        anchors.leftMargin: 10
                                        source: "../imgs/dashboard/addVideo.png"
                                    }

                                    GeneralMouseArea {
                                        onClicked: {
                                            // close toolBar before doing other things
                                            toolBar.close()

                                            // setItemType(currentSelectedItemIndex, "video")
                                            focusItemRequest(currentSelectedItemIndex, "start")
                                        }
                                    }
                                }

                                Rectangle {
                                    id: addHeaderBtn
                                    width: 30
                                    height: 30
                                    anchors.left: addVideoBtn.right
                                    anchors.leftMargin: 10
                                    anchors.verticalCenter: parent.verticalCenter
                                    radius: width / 2
                                    border.width: 2
                                    border.color: "#d8d8d8"

                                    Image {
                                        id: sHeaderBtn
                                        width: 12
                                        height: 12
                                        anchors.centerIn: parent
                                        source: "../imgs/dashboard/addSectionHeader.png"
                                    }

                                    GeneralMouseArea {
                                        onClicked: {
                                            // close toolBar before doing other things
                                            toolBar.close()

                                            setItemType(currentSelectedItemIndex, "sectionHeader")
                                            focusItemRequest(currentSelectedItemIndex, "start")
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
        id: effect0
        anchors.fill: cloneBar
        glowRadius: 5
        spread: 0.1
        color: "#d8d8d8"
        cornerRadius: cloneBar.radius + glowRadius
        visible: cloneBar.visible
    }

    Rectangle {
        id: cloneBar
        width: 400
        height: 48
        anchors.top: parent.top
        anchors.topMargin: 60
        anchors.right: contentPanel.right
        radius: 3
        visible: false

        function dismiss() {
            urlInput.text = ""
            cloneBar.visible = false
        }

        TextInput {
            id: urlInput
            width: parent.width - runCloneBtn.width - anchors.leftMargin * 3
            height: 30
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 16
            color: "#8a8a8a"
        }

        Rectangle {
            id: runCloneBtn
            width: 60
            height: 32
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            radius: width / 2
            color: metaEditPanel.baseColor

            Text {
                width: 32
                height: 18
                anchors.top: parent.top
                anchors.topMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 16
                font.bold: true
                color: "white"
                text: "采集"
            }

            GeneralMouseArea {
                onClicked: {
                    var url = urlInput.text
                    // TODO: validate url
                    mainWindow.importArticleRequest(url)
                    cloneBar.dismiss()
                }
            }
        }
    }

    RectangularGlow {
        id: effect1
        anchors.fill: metaEditPanel
        glowRadius: 10
        spread: 0.1
        color: "#d8d8d8"
        cornerRadius: metaEditPanel.radius + glowRadius
        visible: metaEditPanel.visible
    }

    Rectangle {
        id: metaEditPanel
        width: 300
        height: 400
        anchors.top: parent.top
        anchors.topMargin: 60
        anchors.right: contentPanel.right
        radius: 5
        visible: false

        property string baseColor: "#52D57A"

        GeneralMouseArea {
            cursorShape: Qt.ArrowCursor
        }

        Column {
            anchors.fill: parent

            Item {
                id: metaEditTitleBar
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
                id: metaEditItems
                width: parent.width
                height: parent.height
                        - metaEditTitleBar.height
                        - metaEditBottomBar.height

                Column {
                    anchors.fill: parent

                    Repeater {
                        model: aeModel
                        delegate: Item {
                            id: aeDelegate
                            width: metaEditPanel.width
                            height: metaEditItems.height / aeModel.count

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
                                color: metaEditPanel.baseColor
                                onTextChanged: {
                                    aeModel.setProperty(index, "value", text)
                                }
                            }

                            Rectangle {
                                width: valInput.width
                                height: 2
                                color: valInput.text.length > 0
                                       ? metaEditPanel.baseColor
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
                id: metaEditBottomBar
                width: parent.width
                height: 60

                Rectangle {
                    width: 60
                    height: 32
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    radius: width / 2
                    color: metaEditPanel.baseColor

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
                            metaEditPanel.visible = false
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
                            metaEditPanel.visible = false
                        }
                    }
                }
            }
        }
    }
}
