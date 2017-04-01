"use strict";

function decorHrefs() {
    var n = window.PointerEvent ? { end: "pointerup", enter: "pointerenter", leave: "pointerleave" } : { end: "touchend", enter: "mouseenter", leave: "mouseleave" };
    var hrefs = document.querySelector("#embed").shadowRoot.querySelectorAll("a")
    hrefs.forEach(function(e, r) {
        e.style.textDecoration = "none"
        e.style.pointerEvents = "auto"
        e.style.boxShadow = "inset 0 -5px 0 rgba(123,195,222,.5)"
        e.style.transition = "all .15s ease-in-out"
        e.style.webkitTransition = "all .15s ease-in-out"
        e.style.paddingBottom = "4px"
        e.style.color = "#282828"

        e.addEventListener(n.enter, function(n) {
            e.style.color = "#578B9E"
            e.style.boxShadow = "none"
        });

        e.addEventListener(n.leave, function(n) {
            e.style.color = "#282828"
            e.style.boxShadow = "inset 0 -5px 0 rgba(123,195,222,.5)"
        });
    })
}

var Strut = {
    ready: function(e) { 
        document.readyState !== "loading" 
        ? e() 
        : document.addEventListener("DOMContentLoaded", e) }
};

Strut.ready(function() {
    decorHrefs()
});
