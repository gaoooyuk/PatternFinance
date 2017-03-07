"use strict";

function initPublishBox() {
	var n = window.PointerEvent ? { end: "pointerup", enter: "pointerenter", leave: "pointerleave" } : { end: "touchend", enter: "mouseenter", leave: "mouseleave" };
    var closeTimeout = null

	var pBox = document.querySelector("#embed").shadowRoot.querySelector("#publishBox");
    pBox.addEventListener(n.enter, function(n) {
    	if (closeTimeout) {
    		clearTimeout(closeTimeout)
    	}
    });

    pBox.addEventListener(n.leave, function(n) {
		closeTimeout = setTimeout(function() { pBoxStyle.opacity = "0"; }, 50)
    });

    var pBoxStyle = pBox.style
    pBoxStyle.opacity = "0";
    pBoxStyle.borderRadius = "4px";
    pBoxStyle.boxShadow = "0 50px 100px rgba(50, 50, 93, .1), 0 15px 35px rgba(50, 50, 93, .15), 0 5px 15px rgba(0, 0, 0, .1)";
    pBoxStyle.transitionDuration = ".25s";
    pBoxStyle.transitionProperty = "transform, opacity";
    pBoxStyle.willChange = "transform, opacity";

	var pBtn = document.querySelector("#publishBtn");
    pBtn.addEventListener(n.enter, function(n) {
        if (n.pointerType == "touch") return;

        if (String(pBtn.innerHTML).indexOf("发布") < 0) {
        	pBoxStyle.opacity = "0";
        	return
        }

        var gm1 = pBtn.getBoundingClientRect()
        var gm2 = pBox.getBoundingClientRect()
        var l = (gm1.left + gm1.width / 2 - gm2.width / 2)
        if (l + gm2.width > window.innerWidth) {
            l = window.innerWidth - gm2.width
        }

        pBoxStyle.left = l + "px"
        pBoxStyle.visibility = 'inherit';
        setTimeout(function() { pBoxStyle.opacity = "1"; }, 50)
    });

    pBtn.addEventListener(n.leave, function(n) {
        closeTimeout = setTimeout(function() { pBoxStyle.opacity = "0"; }, 50)
    });

	pBtn.addEventListener('click', function() {
	    if (String(pBtn.innerHTML).indexOf("发布") >= 0) {
			return
		}
		pBoxStyle.opacity = "0";
		window.location = '/dashboard'
	});
}

function initImportBox() {
	if (typeof window.FileReader === 'undefined') {
		console.log("File Drag&Drop not available.")
	}

	var iptBox = document.querySelector("#embed").shadowRoot.querySelector("#importBox");
	iptBox.style.pointerEvents = "auto"
	iptBox.ondragover = function(e) {
		e.preventDefault();
		return false; 
	};
	iptBox.ondrop = function(e) {
		e.preventDefault();
		var file = e.dataTransfer.files[0]
		// console.log(file);

		var lastModified = file.lastModified
		var fileName = file.name
		var fileSize = file.size
		var canProcess = false
		var docType = ""
		if ("text/markdown" === file.type) {
			canProcess = true
			docType = ".md"
		} else if ("text/plain" === file.type) {
			canProcess = true
			docType = ".txt"
		} else if ("" === file.type) {
			if (fileName.endsWith(".lm")) {
				canProcess = true
				docType = ".lm"
			}
		}

		if (canProcess) {
			var reader = new FileReader();
			reader.onload = function (fe) {
				var arr = []
				if (".md" === docType) {
					arr = parseMarkdownFile(fe.target.result)
				} else if (".lm" === docType) {
					arr = parseListModelFile(fe.target.result)
				} else if (".txt" === docType) {
					arr = parseTxtFile(fe.target.result)
				}

				if (arr.length > 0) {
					var ImportEvent = new CustomEvent("ImportMessage",
						{
							detail: {
								message: arr,
								time: new Date()
							},
							bubbles: false,
							cancelable: true
						});

					iptBox.dispatchEvent(ImportEvent);
				}
			};

			reader.readAsText(file)
		}

		return false;
	};
}

function initAdminTools() {
	var ul = document.querySelector(".productsGroup")
	var li = document.createElement("li");    
	var a = document.createElement("a");
	a.className = "linkContainer item-atlas"
	a.href = "javascript:void(0)"
	a.innerHTML = "<svg viewBox=\"0 0 48 48\"><path fill=\"#FCD669\" class=\"hover-fillLight\" d=\"M24 0c13.255 0 24 10.745 24 24S37.255 48 24 48 0 37.255 0 24 10.745 0 24 0z\"></path><path fill=\"#CE7C3A\" class=\"hover-fillDark\" d=\"M24.012 1.834c.366.005.73.196.92.575l16.825 33.72c.396.79-.314 1.685-1.175 1.48L24 33.626V1.834h.01z\"></path><path fill=\"#FFF\" d=\"M24 1.834v31.794l-16.584 3.98A1.043 1.043 0 0 1 6.24 36.13L23.067 2.41c.195-.39.572-.58.947-.576H24z\"></path></svg><div class=\"productLinkContent\"><h3 class=\"linkTitle\">待审文章 23篇</h3><p class=\"linkSub\">需要人工审核的文章总数</p></div>"
	li.appendChild(a);
	ul.appendChild(li);
}

function changePublishBtnVisibility(show) {
	var pBtn = document.querySelector("#publishBtn");
    pBtn.innerHTML = show ? "发布" : "返回"
}

function parseMarkdownFile(data) {
	var arr = []

	var md = window.markdownit();
	var result = md.render(data);
	console.log(result)

	return arr
}

function parseListModelFile(data) {
	var arr = []
	return arr
}

function parseTxtFile(data) {
	var arr = []
	var lines = data.split('\n');
	for (var i in lines) {
		var line = lines[i]
		if ("" === line.trim()) {
			continue
		}
		arr.push({
			"content": line,
			"type": "txt",
			"ratio": 1
		})
	}

	return arr
}

function globalNavDropdowns(e) {
    var t = this;
    this.container = document.querySelector(e),
    this.root = this.container.querySelector(".navRoot"),
    this.primaryNav = this.root.querySelector(".navSection.primary"),
    this.primaryNavItem = this.root.querySelector(".navSection.primary .rootLink:last-child"),
    this.secondaryNavItem = this.root.querySelector(".navSection.secondary .rootLink:first-child"),
    this.checkCollision(),
    window.addEventListener("load", this.checkCollision.bind(this)),
    window.addEventListener("resize", this.checkCollision.bind(this)),
    this.container.classList.add("noDropdownTransition"),
    this.dropdownBackground = this.container.querySelector(".dropdownBackground"),
    this.dropdownBackgroundAlt = this.container.querySelector(".alternateBackground"),
    this.dropdownContainer = this.container.querySelector(".dropdownContainer"),
    this.dropdownRoots = Strut.queryArray(".hasDropdown", this.root),
    this.dropdownSections = Strut.queryArray(".dropdownSection", this.container).map(function(e) {
        return { el: e, name: e.getAttribute("data-dropdown"), content: e.querySelector(".dropdownContent") }
    });

    var n = window.PointerEvent ? { end: "pointerup", enter: "pointerenter", leave: "pointerleave" } : { end: "touchend", enter: "mouseenter", leave: "mouseleave" };
    this.dropdownRoots.forEach(function(e, r) {
        e.addEventListener(n.end, function(n) {
            n.preventDefault(),
            n.stopPropagation(),
            t.toggleDropdown(e)
        }),
        e.addEventListener(n.enter, function(n) {
            if (n.pointerType == "touch") return;
            t.stopCloseTimeout(), t.openDropdown(e)
        }), e.addEventListener(n.leave, function(e) {
            if (e.pointerType == "touch") return;
            t.startCloseTimeout()
        })
    }), 
    this.dropdownContainer.addEventListener(n.end, function(e) {
    	e.stopPropagation() 
    }), 
    this.dropdownContainer.addEventListener(n.enter, function(e) {
        if (e.pointerType == "touch") return;
        t.stopCloseTimeout()
    }), this.dropdownContainer.addEventListener(n.leave, function(e) {
        if (e.pointerType == "touch") return;
        t.startCloseTimeout()
    }), 
    document.body.addEventListener(n.end, function(e) {
    	Strut.touch.isDragging || t.closeDropdown() 
    })
}

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
        this.closeButton && this.closeButton.addEventListener(n, function(e) { t.closeAllPopups() }), document.body.addEventListener(n, function(e) { Strut.touch.isDragging || t.closeAllPopups() }, !1)
}

var Strut = {
    random: function(e, t) {
        return Math.random() * (t - e) + e
    },
    arrayRandom: function(e) {
        return e[Math.floor(Math.random() * e.length)]
    },
    interpolate: function(e, t, n) {
        return e * (1 - n) + t * n
    },
    rangePosition: function(e, t, n) {
        return (n - e) / (t - e)
    },
    clamp: function(e, t, n) {
        return Math.max(Math.min(e, n), t)
    },
    queryArray: function(e, t) {
        return t || (t = document.body), Array.prototype.slice.call(t.querySelectorAll(e))
    },
    ready: function(e) { document.readyState !== "loading" ? e() : document.addEventListener("DOMContentLoaded", e) }
};

Strut.ready(function() {
    initPublishBox();
    initImportBox();
    initAdminTools();
});

Strut.isRetina = window.devicePixelRatio > 1.3, Strut.mobileViewportWidth = 670, Strut.isMobileViewport = window.innerWidth < Strut.mobileViewportWidth, window.addEventListener("resize", function() { Strut.isMobileViewport = window.innerWidth < Strut.mobileViewportWidth }), Strut.touch = { isSupported: "ontouchstart" in window || navigator.maxTouchPoints, isDragging: !1 }, document.addEventListener("DOMContentLoaded", function() { document.body.addEventListener("touchmove", function() { Strut.touch.isDragging = !0 }), document.body.addEventListener("touchstart", function() { Strut.touch.isDragging = !1 }) }), Strut.load = {
        images: function(e, t) {
            typeof e == "string" && (e = [e]);
            var n = -e.length;
            e.forEach(function(e) {
                var r = new Image;
                r.src = e, r.onload = function() { n++, n === 0 && t && t() }
            })
        },
        css: function(e, t) {
            var n = document.createElement("link"),
                r = window.readConfig("strut_files") || {},
                i = r[e];
            if (!i) throw new Error('CSS file "' + e + '" not found in strut_files config');
            n.href = i, n.rel = "stylesheet", document.head.appendChild(n), t && (n.onload = t)
        },
        js: function(e, t) {
            var n = document.createElement("script"),
                r = window.readConfig("strut_files") || {},
                i = r[e];
            if (!i) throw new Error('Javascript file "' + e + '" not found in strut_files config');
            n.src = i, document.head.appendChild(n), t && (n.onload = t)
        }
    }, Strut.supports = {
        es6: function() {
            try {
                return new Function("(a = 0) => a"), !0
            } catch (e) {
                return !1
            }
        }(),
        pointerEvents: function() {
            var e = document.createElement("a").style;
            return e.cssText = "pointer-events:auto", e.pointerEvents === "auto"
        }(),
        positionSticky: function() {
            var e = "position:",
                t = "sticky",
                n = document.createElement("a"),
                r = n.style,
                i = " -webkit- -moz- -o- -ms- ".split(" ");
            return r.cssText = e + i.join(t + ";" + e).slice(0, -e.length), r.position.indexOf(t) !== -1
        }(),
        masks: function() {
            return !/MSIE|Trident|Edge/i.test(navigator.userAgent)
        }()
    }, globalNavDropdowns.prototype.checkCollision = function() {
        var e = this;
        if (Strut.isMobileViewport) return;
        if (e.compact == 1) {
            var t = document.body.clientWidth,
                n = e.primaryNav.getBoundingClientRect();
            n.left + n.width / 2 > t / 2 && (e.container.classList.remove("compact"), e.compact = !1)
        } else {
            (e.container.classList.add("compact"), e.compact = !0)
        }
    }, globalNavDropdowns.prototype.openDropdown = function(e) {
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
        h = Math.round(Math.max(h, 10)),
            clearTimeout(this.disableTransitionTimeout),
            this.enableTransitionTimeout = setTimeout(function() { t.container.classList.remove("noDropdownTransition") }, 50),
            this.dropdownBackground.style.transform = "translateX(" + h + "px) scaleX(" + f + ") scaleY(" + l + ")",
            this.dropdownContainer.style.transform = "translateX(" + h + "px)",
            this.dropdownContainer.style.width = i + "px",
            this.dropdownContainer.style.height = s + "px";
        var p = Math.round(c.left + c.width / 2);
        // this.dropdownArrow.style.transform = "translateX(" + p + "px) rotate(45deg)";
        var d = o.children[0].offsetHeight / l;
        // this.dropdownBackgroundAlt.style.transform = "translateY(" + d + "px)"
    }, globalNavDropdowns.prototype.closeDropdown = function() {
        var e = this;
        if (!this.activeDropdown) return;
        this.dropdownRoots.forEach(function(e, t) { e.classList.remove("active") }),
            clearTimeout(this.enableTransitionTimeout),
            this.disableTransitionTimeout = setTimeout(function() { e.container.classList.add("noDropdownTransition") }, 50),
            this.container.classList.remove("overlayActive"),
            this.container.classList.remove("dropdownActive"),
            this.activeDropdown = undefined
    }, globalNavDropdowns.prototype.toggleDropdown = function(e) {
        this.activeDropdown === e ? this.closeDropdown() : this.openDropdown(e)
    }, globalNavDropdowns.prototype.startCloseTimeout = function() {
        var e = this;
        e.closeDropdownTimeout = setTimeout(function() { e.closeDropdown() }, 50)
    }, globalNavDropdowns.prototype.stopCloseTimeout = function() {
        var e = this;
        clearTimeout(e.closeDropdownTimeout)
    }, globalNavPopup.prototype.togglePopup = function() {
        var e = this.root.classList.contains(this.activeClass);
        this.closeAllPopups(!0), e || this.root.classList.add(this.activeClass)
    }, globalNavPopup.prototype.closeAllPopups = function(e) {
        var t = document.getElementsByClassName(this.activeClass);
        for (var n = 0; n < t.length; n++) t[n].classList.remove(this.activeClass)
    }, Strut.supports.pointerEvents || Strut.load.css("v3/shared/navigation_ie10.css"), 
Strut.ready(function() { 
	new globalNavDropdowns(".globalNav"), 
	new globalNavPopup(".globalNav .navSection.mobile") 
});
