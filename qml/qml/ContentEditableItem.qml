import QtQuick 2.5

Item {
    id: input

    signal addItemBeforeRequest(string slicedStr)
    signal addItemAfterRequest(string slicedStr)
    signal removeMyself()
    signal inputTextChanged(string text)
    signal itemSelected()

    function initMouseEvents() {
        var impl = input.dom
        impl.addEventListener('mouseup', function(e) {
            updateToolBar()
        });
        impl.onfocus = function() {
            console.log("item on focus: ", index)
            input.itemSelected()
        };
    }

    function initKeyboardEvents() {
        var impl = input.dom
        impl.contentEditable = "plaintext-only"
        impl.addEventListener('keydown', function(e) {
            if ("txt" === type || "sectionHeader" === type) {
                handleTextKeyboardEvents(e)
            } else if ("img" === type) {
                handleImageKeyboardEvents(e)
            }
        }, false);
    }

    function initStyles() {
        var impl = input.dom
        var css = impl.style
        css.cursor = "text"
        css.outline = "transparent"
        // enable pointer events, it was disabled by default (qt.js)
        css.pointerEvents = "auto"

        if ("txt" === type) {
            css.textAlign = "left"
            css.fontSize = "18px"
            css.color = "#4a4a4a"
            css.lineHeight = "30px"
            css.whiteSpace = "pre-wrap"
            css.wordWrap = "break-word"
        }
    }

    function initContent() {
        var impl = input.dom
        impl.innerHTML = content

        updateImplicitHeight()
    }

    function updateImplicitHeight() {
        var impl = input.dom
        implicitHeight = impl.scrollHeight
    }

    function updateToolBar() {
        toolBar.anchors.topMargin = input.y
        if ("" === input.dom.innerHTML) {
            toolBar.visible = true
        } else {
            toolBar.visible = false
        }
    }

    function handleTextKeyboardEvents(e) {
        var keyName = e.key;
        console.log("(txt)keyName: ", keyName)

        // We call removal of current element when Backspace pressed AND innerHTML is empty
        if ("Backspace" === keyName && "" === input.dom.innerHTML) {
            input.removeMyself()
            return
        }

        setTimeout(function() {
            input.inputTextChanged(input.dom.innerHTML)
        }, 50)

        if (getPreventKeys().indexOf(keyName) >= 0) {
            e.preventDefault()

            var caretPosition = getCaretCharacterOffsetWithin(input.dom)
            var currentContent = String(input.dom.innerHTML)

            var rem = 0
            var caretOffset = 1
            var newContent = ""

            if ("Enter" === keyName) {
                caretOffset = 0
                if (0 === caretPosition) {
                    input.addItemBeforeRequest("")
                } else {
                    var slicedStr = currentContent.slice(caretPosition)
                    newContent = currentContent.slice(0, caretPosition)
                    input.addItemAfterRequest(slicedStr)
                }
            }

            input.dom.innerHTML = newContent
            setCaretAtIndex(input.dom, Math.max(0, caretPosition+caretOffset))
        }
    }

    function handleImageKeyboardEvents(e) {
        var keyName = e.key;
        console.log("(image)keyName: ", keyName)

        // We call removal of current element when Backspace pressed AND innerHTML is empty
        if ("Backspace" === keyName) {
            if ("" === input.dom.innerHTML) {
                input.removeMyself()
            } else {
                input.dom.innerHTML = ""
            }

            return
        }

        if (getPreventKeys().indexOf(keyName) >= 0) {
            e.preventDefault()

            if ("Enter" === keyName) {
                // if no image inserted
                if (0 === input.dom.children.length) {
                    var imgUrl = input.dom.innerHTML
                    input.inputTextChanged(imgUrl)

                    // load image
                    var img = new Image();
                    img.onload = function () {
                        input.dom.innerHTML = ""
                        if (img.naturalWidth) {
                            var ratio = img.naturalHeight / img.naturalWidth
                            console.log("(image)ratio: ", ratio)
                            img.width = input.width
                            img.height = img.width * ratio
                            input.height = img.height
                            contentModel.setProperty(index, "ratio", parseFloat(Number(ratio).toFixed(2)))
                        }
                        input.dom.appendChild(img)
                    }
                    img.src = imgUrl;
                } else {
                    input.addItemAfterRequest("")
                }
            }
        }
    }

    function getCaretCharacterOffsetWithin(element) {
        var caretOffset = 0;
        if (typeof window.getSelection != "undefined") {
            var range = document.querySelector("#embed").shadowRoot.getSelection().getRangeAt(0);
            var preCaretRange = range.cloneRange();
            preCaretRange.selectNodeContents(element);
            preCaretRange.setEnd(range.endContainer, range.endOffset);
            caretOffset = preCaretRange.toString().length;
        } else if (typeof document.selection != "undefined" && document.selection.type !== "Control") {
            var textRange = document.selection.createRange();
            var preCaretTextRange = document.body.createTextRange();
            preCaretTextRange.moveToElementText(element);
            preCaretTextRange.setEndPoint("EndToEnd", textRange);
            caretOffset = preCaretTextRange.text.length;
        }
        return caretOffset;
    }

    function setCaretAtIndex(element, idx) {
        if (typeof window.getSelection != "undefined") {
            var sel = document.querySelector("#embed").shadowRoot.getSelection()
            sel.collapse(element.firstChild, idx);
        } else if (typeof document.selection != "undefined" && document.selection.type !== "Control") {
            var textRange = document.selection.createRange();
            sel.moveStart('character', idx);
            sel.select();
        }
    }

    function getPreventKeys() {
        var keys = ["Enter"]
        return keys
    }

    function splice(orig, idx, rem, str) {
        if (-1 === rem) { // Backspace
            return orig.slice(0, Math.max(0, idx-Math.abs(rem))) + str + orig.slice(idx);
        } else if (1 === rem) { // Delete
            return orig.slice(0, Math.max(0, idx)) + str + orig.slice(idx+Math.abs(rem));
        }

        return orig.slice(0, Math.max(0, idx)) + str + orig.slice(idx);
    }

    Connections {
        target: mainWindow
        onFocusItemRequest: {
            if (index === newItemIdx) {
                var impl = input.dom
                impl.focus()
            }
        }
    }

    Component.onCompleted: {
        initMouseEvents()
        initKeyboardEvents()
        initStyles()
        initContent()
    }
}
