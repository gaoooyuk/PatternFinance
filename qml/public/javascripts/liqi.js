"use strict";

function decorHrefs() {
    var n = window.PointerEvent ? { end: "pointerup", enter: "pointerenter", leave: "pointerleave" } : { end: "touchend", enter: "mouseenter", leave: "mouseleave" };
    var hrefs = document.querySelector("#embed").shadowRoot.querySelectorAll("a")
    hrefs.forEach(function(e, r) {
        e.style.textDecoration = "none"
        e.style.pointerEvents = "auto"
        e.style.color = "#58D3F7"

        e.addEventListener(n.enter, function(n) {
            e.style.color = "#58ACFA"
        });

        e.addEventListener(n.leave, function(n) {
            e.style.color = "#58D3F7"
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
