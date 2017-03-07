import QtQuick 2.5

Item {
    id: textInput
//    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
//    lineHeight: 30
//    font.pixelSize: 18
//    color: "#4a4a4a"
//    onTextChanged: {
//        console.log("ss: ", text)
//        inputTextChanged(text)
//    }

    signal addItemBeforeRequest(string slicedStr)
    signal addItemAfterRequest(string slicedStr)
    signal inputTextChanged(string text)

    function initMouseEvents() {
        var input = textInput.dom
        // enable pointer events, it was disabled by default (qt.js)
        input.style.pointerEvents = "auto"
        input.addEventListener('mouseup', function(e) {

        });
    }

    function initKeyboardEvents() {
        var input = textInput.dom
        input.contentEditable = true
        input.addEventListener('keypress', function(e) {
            var keyName = e.key;
            if ("Enter" === keyName) {
                e.preventDefault()
                var caretPosition = getCaretCharacterOffsetWithin(input)
                if (0 === caretPosition) {
                    textInput.addItemBeforeRequest("")
                } else {
                    var slicedStr = textInput.text.slice(caretPosition)
                    textInput.addItemAfterRequest(slicedStr)
                }
            } else {
                console.log(input)
            }
        }, false);
    }

    function initStyles() {
        var input = textInput.dom
        var css = input.style
        css.cursor = "text"
        css.outline = "transparent"
    }

    function initContent() {
        var input = textInput.dom
        input.innerHTML = content
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

    Component.onCompleted: {
        initMouseEvents()
        initKeyboardEvents()
        initStyles()
        initContent()
    }
}
