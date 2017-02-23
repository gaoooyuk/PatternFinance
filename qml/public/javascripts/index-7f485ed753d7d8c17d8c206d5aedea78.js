Strut.ready(function() {
    function e(e) {
        var t = e.querySelector("[name=email]"),
            r = Strut.queryArray("[name=payment_methods]", e),
            i = r.filter(function(e) {
                return e.checked
            }),
            s = i.map(function(e) {
                return e.value
            });
        return { login_method: s[0], token: t.value }
    }

    function t(t) {
        var r = e(t),
            i = new XMLHttpRequest;

        var url = "api/login"
        i.open("POST", url), 
        i.setRequestHeader("Content-Type", "application/json;charset=UTF-8"), 
        i.send(JSON.stringify(r))
    }

    var n = document.querySelector(".notify-box"),
        r = n.querySelector(".notify-form"),
        i = n.querySelector(".notify-close"),
        s = r.querySelector(".methods"),
        o = r.querySelector(".methods-dropdown"),
        u = r.querySelector(".other"),
        f = r.querySelector(".email"),
        l = f.querySelector(".email-field"),
        t_email = n.querySelector("#type_email"),
        t_code = n.querySelector("#type_code"),
        c = f.querySelector(".submit-button");

    t_email.addEventListener("click", function() {
            l.type = "email"
            l.placeholder = "邮箱地址"
            n.classList.remove("methods-open")
        }),
        t_code.addEventListener("click", function() {
            l.type = "text"
            l.placeholder = "输入您的邀请码"
            n.classList.remove("methods-open")
        }),
        o.addEventListener("click", function() { n.classList.add("methods-open") }),
        i.addEventListener("click", function() { n.classList.remove("methods-open") }),
        l.addEventListener("focus", function() { f.classList.add("active") }),
        l.addEventListener("blur", function() { f.classList.remove("active") }),
        r.addEventListener("submit", function(e) {
            e.preventDefault();
            console.log("Submit login request: ", t_email.checked ? "email" : "code")
            var o
            if (t_email.checked) {
                o = l.value.length && l.checkValidity();
            } else {
                // check if code valid
                o = l.value.length
            }
            o ? (t(r), n.classList.add("form-submitted")) : (l.focus())
        })
});
