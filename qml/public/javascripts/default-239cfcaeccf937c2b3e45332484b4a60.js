function globalNavDropdowns(e) {
    var t = this;
    this.container = document.querySelector(e), this.root = this.container.querySelector(".navRoot"), this.primaryNav = this.root.querySelector(".navSection.primary"), this.primaryNavItem = this.root.querySelector(".navSection.primary .rootLink:last-child"), this.secondaryNavItem = this.root.querySelector(".navSection.secondary .rootLink:first-child"), this.checkCollision(), window.addEventListener("load", this.checkCollision.bind(this)), window.addEventListener("resize", this.checkCollision.bind(this)), this.container.classList.add("noDropdownTransition"), this.dropdownBackground = this.container.querySelector(".dropdownBackground"), this.dropdownBackgroundAlt = this.container.querySelector(".alternateBackground"), this.dropdownContainer = this.container.querySelector(".dropdownContainer"), this.dropdownArrow = this.container.querySelector(".dropdownArrow"), this.dropdownRoots = Strut.queryArray(".hasDropdown", this.root), this.dropdownSections = Strut.queryArray(".dropdownSection", this.container).map(function(e) {
        return { el: e, name: e.getAttribute("data-dropdown"), content: e.querySelector(".dropdownContent") } });
    var n = window.PointerEvent ? { end: "pointerup", enter: "pointerenter", leave: "pointerleave" } : { end: "touchend", enter: "mouseenter", leave: "mouseleave" };
    this.dropdownRoots.forEach(function(e, r) { e.addEventListener(n.end, function(n) { n.preventDefault(), n.stopPropagation(), t.toggleDropdown(e) }), e.addEventListener(n.enter, function(n) {
            if (n.pointerType == "touch") return;
            t.stopCloseTimeout(), t.openDropdown(e) }), e.addEventListener(n.leave, function(e) {
            if (e.pointerType == "touch") return;
            t.startCloseTimeout() }) }), this.dropdownContainer.addEventListener(n.end, function(e) { e.stopPropagation() }), this.dropdownContainer.addEventListener(n.enter, function(e) {
        if (e.pointerType == "touch") return;
        t.stopCloseTimeout() }), this.dropdownContainer.addEventListener(n.leave, function(e) {
        if (e.pointerType == "touch") return;
        t.startCloseTimeout() }), document.body.addEventListener(n.end, function(e) { Strut.touch.isDragging || t.closeDropdown() }) }

function globalNavPopup(e) {
    var t = this,
        n = Strut.touch.isSupported ? "touchend" : "click";
    this.activeClass = "globalPopupActive", 
    this.root = document.querySelector(e), 
    this.link = this.root.querySelector(".rootLink"), 
    this.popup = document.querySelector(".popup"),
    this.closeButton = this.root.querySelector(".popupCloseButton"), 
    this.link.addEventListener(n, function(e) { e.stopPropagation(), t.togglePopup() }), 
    this.popup.addEventListener(n, function(e) { e.stopPropagation() }), 
    this.closeButton && this.closeButton.addEventListener(n, function(e) { t.closeAllPopups() }), document.body.addEventListener(n, function(e) { Strut.touch.isDragging || t.closeAllPopups() }, !1) }
window.siteAnalytics = {}, window.siteAnalyticsUtil = {},
    function() {
        function t() {
            return !!window[e] }

        function n(e, n) {
            if (!window.Analytics) return;
            window.Analytics.action(e, n), t() && console.log("emitAction", e, n) }

        function r(e, n) {
            if (!window.Analytics) return;
            window.Analytics.actionOnce(e, n), t() && console.log("emitActionOnce", e, n) }

        function i(e, n) {
            if (!window.Analytics) return;
            window.Analytics.modal(e, n), t() && console.log("emitModal", e, n) }

        function s() { window.siteAnalyticsUtil.emitAction = n, window.siteAnalyticsUtil.emitActionOnce = r }
        var e = "SITE_ANALYTICS_DEBUG";
        s() }(),
    function() {
        function r(r) {
            var s = i(r),
                o = {};
            return s.getAttribute(e) && (o.action = s.getAttribute(e)), s.getAttribute(n) && (o.modal = s.getAttribute(n)), s.getAttribute(t) && (o.params = { source: s.getAttribute(t) }), o }

        function i(t) {
            return t.getAttribute(e) || t.getAttribute(n) ? t : !t.parentNode || t.tagName === "BODY" ? null : i(t.parentNode) }

        function s(e) {
            return !!i(e) }

        function o(e) {
            var t = r(e);
            t.modal && window.siteAnalyticsUtil.emitModal(t.modal, t.params), t.action && window.siteAnalyticsUtil.emitAction(t.action, t.params) }

        function u() { window.siteAnalytics.hasAnalyticsAttributes = s, window.siteAnalytics.trackByAttributes = o }
        var e = "data-analytics-action",
            t = "data-analytics-source",
            n = "data-analytics-modal";
        u() }(),
    function() {
        function n(e) {
            return e.matches("form *") }

        function r(t) {
            if (!n(t.target)) return;
            window.siteAnalyticsUtil.emitAction(e, { name: t.target.getAttribute("name"), value: t.target.value }) }

        function i(e) {
            if (e.target.tagName !== "FORM") return;
            window.siteAnalyticsUtil.emitAction(t) }

        function s() { document.addEventListener("change", r), document.addEventListener("submit", i) }
        var e = "form_input",
            t = "form_submit";
        s() }(),
    function() {
        function n(n) {
            if (t[n]) return;
            t[n] = !0, window.siteAnalyticsUtil.emitAction(e, { dropdown: n }) }

        function r() { window.siteAnalytics.trackGlobalNavDropdownOpen = n }
        var e = "nav_dropdown_open",
            t = {};
        r() }(),
    function() {
        function i() { window.siteAnalyticsUtil.emitActionOnce(e) }

        function s() { window.siteAnalyticsUtil.emitActionOnce(t) }

        function o(e) {
            var t = e.innerText.trim().toLowerCase();
            if (r[t]) return;
            r[t] = !0, window.siteAnalyticsUtil.emitAction(n, { text: t }) }

        function u() { window.siteAnalytics.trackHomePageNotebook = o, window.siteAnalytics.trackRadarIcosahedron = i, window.siteAnalytics.trackRadarFraudChart = s }
        var e = "radar_icosahedron",
            t = "radar_fraud_chart",
            n = "home_page_notebook",
            r = {};
        u() }(),
    function() {
        function r(e) {
            return !!e.getAttribute("href") }

        function i(e) {
            return e.trim().replace(/\s+/g, " ") }

        function s(r) {
            var i = r.className.toLowerCase(),
                s = r.getAttribute("href"),
                o = /\.pdf$|\.pdf#|\.pdf\?/i;
            return o.test(r.href) ? n : i.indexOf("button") !== -1 || s === "#" ? t : e }

        function o(e) {
            var t = s(e),
                n = { text: i(e.innerText) };
            window.siteAnalyticsUtil.emitAction(t, n) }

        function u(e) {
            return e.tagName === "A" ? e : e.parentNode ? u(e.parentNode) : null }

        function a(e) {
            if (window.siteAnalytics.hasAnalyticsAttributes(e.target)) { window.siteAnalytics.trackByAttributes(e.target);
                return }
            var t = u(e.target);
            if (!t || !r(t)) return;
            o(t) }

        function f() { document.addEventListener("click", a) }
        var e = "inline_link",
            t = "button",
            n = "pdf_link";
        f() }(),
    function() {
        function r(t) {
            return o(e, t) }

        function i(e) {
            return o(n, e) }

        function s(e) {
            return o(t, e) }

        function o(e, t) {
            var n = t;
            typeof t != "string" && (n = a(t)), window.siteAnalyticsUtil.emitAction(e, { video: n }) }

        function u(e) {
            return e.currentSrc || e.getAttribute("src") || e.querySelector("source").getAttribute("src") }

        function a(e) {
            var t = u(e),
                n = t.slice(t.lastIndexOf("/") + 1);
            return n.slice(0, n.lastIndexOf(".")) }

        function f(e) {
            if (e.target.tagName !== "VIDEO") return;
            i(e.target) }

        function l(e) {
            if (e.target.tagName !== "VIDEO") return;
            s(e.target) }

        function c() { document.addEventListener("play", f, !0), document.addEventListener("ended", l, !0), window.siteAnalytics.trackVideoExpand = r, window.siteAnalytics.trackVideoPlay = i, window.siteAnalytics.trackVideoEnd = s }
        var e = "video_expand",
            t = "video_end",
            n = "video_play";
        c() }(),
    function() { window.$ && window.$.ajaxPrefilter && $(function() {
            return $.ajaxPrefilter(function(e, t, n) {
                var r, i;
                return i = $("meta[name=csrf-token]"), r = i ? i.attr("content") : "", n.setRequestHeader("x-stripe-csrf-token", r) }) }) }.call(this), "use strict";
var Strut = { random: function(e, t) {
        return Math.random() * (t - e) + e }, arrayRandom: function(e) {
        return e[Math.floor(Math.random() * e.length)] }, interpolate: function(e, t, n) {
        return e * (1 - n) + t * n }, rangePosition: function(e, t, n) {
        return (n - e) / (t - e) }, clamp: function(e, t, n) {
        return Math.max(Math.min(e, n), t) }, queryArray: function(e, t) {
        return t || (t = document.body), Array.prototype.slice.call(t.querySelectorAll(e)) }, ready: function(e) { document.readyState !== "loading" ? e() : document.addEventListener("DOMContentLoaded", e) } };
Strut.isRetina = window.devicePixelRatio > 1.3, Strut.mobileViewportWidth = 670, Strut.isMobileViewport = window.innerWidth < Strut.mobileViewportWidth, window.addEventListener("resize", function() { Strut.isMobileViewport = window.innerWidth < Strut.mobileViewportWidth }), Strut.touch = { isSupported: "ontouchstart" in window || navigator.maxTouchPoints, isDragging: !1 }, document.addEventListener("DOMContentLoaded", function() { document.body.addEventListener("touchmove", function() { Strut.touch.isDragging = !0 }), document.body.addEventListener("touchstart", function() { Strut.touch.isDragging = !1 }) }), Strut.load = { images: function(e, t) { typeof e == "string" && (e = [e]);
        var n = -e.length;
        e.forEach(function(e) {
            var r = new Image;
            r.src = e, r.onload = function() { n++, n === 0 && t && t() } }) }, css: function(e, t) {
        var n = document.createElement("link"),
            r = window.readConfig("strut_files") || {},
            i = r[e];
        if (!i) throw new Error('CSS file "' + e + '" not found in strut_files config');
        n.href = i, n.rel = "stylesheet", document.head.appendChild(n), t && (n.onload = t) }, js: function(e, t) {
        var n = document.createElement("script"),
            r = window.readConfig("strut_files") || {},
            i = r[e];
        if (!i) throw new Error('Javascript file "' + e + '" not found in strut_files config');
        n.src = i, document.head.appendChild(n), t && (n.onload = t) } }, Strut.supports = { es6: function() {
        try {
            return new Function("(a = 0) => a"), !0 } catch (e) {
            return !1 } }(), pointerEvents: function() {
        var e = document.createElement("a").style;
        return e.cssText = "pointer-events:auto", e.pointerEvents === "auto" }(), positionSticky: function() {
        var e = "position:",
            t = "sticky",
            n = document.createElement("a"),
            r = n.style,
            i = " -webkit- -moz- -o- -ms- ".split(" ");
        return r.cssText = e + i.join(t + ";" + e).slice(0, -e.length), r.position.indexOf(t) !== -1 }(), masks: function() {
        return !/MSIE|Trident|Edge/i.test(navigator.userAgent) }() }, globalNavDropdowns.prototype.checkCollision = function() {
    var e = this;
    if (Strut.isMobileViewport) return;
    if (e.compact == 1) {
        var t = document.body.clientWidth,
            n = e.primaryNav.getBoundingClientRect();
        n.left + n.width / 2 > t / 2 && (e.container.classList.remove("compact"), e.compact = !1) } else {
        (e.container.classList.add("compact"), e.compact = !0) } }, globalNavDropdowns.prototype.openDropdown = function(e) {
    var t = this;
    if (this.activeDropdown === e) return;
    this.container.classList.add("overlayActive"), this.container.classList.add("dropdownActive"), this.activeDropdown = e, this.dropdownRoots.forEach(function(e, t) { e.classList.remove("active") }), e.classList.add("active");
    var n = e.getAttribute("data-dropdown"),
        r = "left",
        i, s, o;
    this.dropdownSections.forEach(function(e) { e.el.classList.remove("active"), e.el.classList.remove("left"), e.el.classList.remove("right"), e.name == n ? (e.el.classList.add("active"), r = "right", i = e.content.offsetWidth, s = e.content.offsetHeight, o = e.content) : e.el.classList.add(r) });
    var u = 520,
        a = 400,
        f = i / u,
        l = s / a,
        c = e.getBoundingClientRect(),
        h = c.left + c.width / 2 - i / 2;
    h = Math.round(Math.max(h, 10)), clearTimeout(this.disableTransitionTimeout), this.enableTransitionTimeout = setTimeout(function() { t.container.classList.remove("noDropdownTransition") }, 50), this.dropdownBackground.style.transform = "translateX(" + h + "px) scaleX(" + f + ") scaleY(" + l + ")", this.dropdownContainer.style.transform = "translateX(" + h + "px)", this.dropdownContainer.style.width = i + "px", this.dropdownContainer.style.height = s + "px";
    var p = Math.round(c.left + c.width / 2);
    this.dropdownArrow.style.transform = "translateX(" + p + "px) rotate(45deg)";
    var d = o.children[0].offsetHeight / l;
    this.dropdownBackgroundAlt.style.transform = "translateY(" + d + "px)", window.siteAnalytics && window.siteAnalytics.trackGlobalNavDropdownOpen && window.siteAnalytics.trackGlobalNavDropdownOpen(n) }, globalNavDropdowns.prototype.closeDropdown = function() {
    var e = this;
    if (!this.activeDropdown) return;
    this.dropdownRoots.forEach(function(e, t) { e.classList.remove("active") }), clearTimeout(this.enableTransitionTimeout), this.disableTransitionTimeout = setTimeout(function() { e.container.classList.add("noDropdownTransition") }, 50), this.container.classList.remove("overlayActive"), this.container.classList.remove("dropdownActive"), this.activeDropdown = undefined }, globalNavDropdowns.prototype.toggleDropdown = function(e) { this.activeDropdown === e ? this.closeDropdown() : this.openDropdown(e) }, globalNavDropdowns.prototype.startCloseTimeout = function() {
    var e = this;
    e.closeDropdownTimeout = setTimeout(function() { e.closeDropdown() }, 50) }, globalNavDropdowns.prototype.stopCloseTimeout = function() {
    var e = this;
    clearTimeout(e.closeDropdownTimeout) }, globalNavPopup.prototype.togglePopup = function() {
    var e = this.root.classList.contains(this.activeClass);
    this.closeAllPopups(!0), e || this.root.classList.add(this.activeClass) }, globalNavPopup.prototype.closeAllPopups = function(e) {
    var t = document.getElementsByClassName(this.activeClass);
    for (var n = 0; n < t.length; n++) t[n].classList.remove(this.activeClass) }, Strut.supports.pointerEvents || Strut.load.css("v3/shared/navigation_ie10.css"), Strut.ready(function() { new globalNavDropdowns(".globalNav"), new globalNavPopup(".globalNav .navSection.mobile"), new globalNavPopup(".globalFooterNav .select.country"), new globalNavPopup(".globalFooterNav .select.language") });
