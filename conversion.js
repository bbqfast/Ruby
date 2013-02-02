(function () {
    var f = null;
    var h = "google_conversion_id google_conversion_format google_conversion_type google_conversion_order_id google_conversion_language google_conversion_value google_conversion_domain google_conversion_label google_conversion_color google_disable_viewthrough google_remarketing_only google_remarketing_for_search google_conversion_items google_custom_params google_conversion_date google_conversion_time google_conversion_js_version onload_callback opt_image_generator google_is_call google_conversion_page_url".split(" ");

    function j(b) {
        return b != f ? escape(b.toString()) : ""
    }
    function k(b, c) {
        var g = j(c);
        if ("" != g) {
            var a = j(b);
            if ("" != a) return "&".concat(a, "=", g)
        }
        return ""
    }
    function l(b) {
        var c = typeof b;
        return b == f || "object" == c || "function" == c ? f : String(b).replace(/,/g, "\\,").replace(/;/g, "\\;").replace(/=/g, "\\=")
    }

    function m(b) {
        var c;
        b = b.google_custom_params;
        if (!b || "object" != typeof b || "function" == typeof b.join) c = "";
        else {
            var g = [];
            for (c in b) if (Object.prototype.hasOwnProperty.call(b, c)) {
                var a = b[c];
                if (a && "function" == typeof a.join) {
                    for (var d = [], e = 0; e < a.length; ++e) {
                        var s = l(a[e]);
                        s != f && d.push(s)
                    }
                    a = 0 == d.length ? f : d.join(",")
                } else a = l(a);
                (d = l(c)) && a != f && g.push(d + "=" + a)
            }
            c = g.join(";")
        }
        return "" == c ? "" : "&".concat("data=", encodeURIComponent(c))
    }

    function n(b) {
        return "number" != typeof b && "string" != typeof b ? "" : j(b.toString())
    }
    function p(b) {
        if (!b) return "";
        b = b.google_conversion_items;
        if (!b) return "";
        for (var c = [], g = 0, a = b.length; g < a; g++) {
            var d = b[g],
                e = [];
            d && (e.push(n(d.value)), e.push(n(d.quantity)), e.push(n(d.item_id)), e.push(n(d.adwords_grouping)), e.push(n(d.sku)), c.push("(" + e.join("*") + ")"))
        }
        return 0 < c.length ? "&item=" + c.join("") : ""
    }

    function q(b, c, g) {
        var a = [];
        if (b) {
            var d = b.screen;
            d && (a.push(k("u_h", d.height)), a.push(k("u_w", d.width)), a.push(k("u_ah", d.availHeight)), a.push(k("u_aw", d.availWidth)), a.push(k("u_cd", d.colorDepth)));
            b.history && a.push(k("u_his", b.history.length))
        }
        g && "function" == typeof g.getTimezoneOffset && a.push(k("u_tz", -g.getTimezoneOffset()));
        c && ("function" == typeof c.javaEnabled && a.push(k("u_java", c.javaEnabled())), c.plugins && a.push(k("u_nplug", c.plugins.length)), c.mimeTypes && a.push(k("u_nmime", c.mimeTypes.length)));
        return a.join("")
    }
    function r(b, c, g) {
        var a = "";
        if (c) {
            var a = a + k("ref", c.referrer != f ? c.referrer.toString().substring(0, 256) : ""),
                d;
            c = 2;
            try {
                if (b.top.document == b.document) c = 0;
                else {
                    var e = b.top;
                    try {
                        d = !! e.location.href || "" === e.location.href
                    } catch (s) {
                        d = !1
                    }
                    d && (c = 1)
                }
            } catch (L) {}
            d = c;
            e = "";
            e = g ? g : 1 == d ? b.top.location.href : b.location.href;
            a += k("url", e != f ? e.toString().substring(0, 256) : "");
            a += k("frm", d)
        }
        return a
    }

    function t(b) {
        return b && b.location && b.location.protocol && "https:" == b.location.protocol.toString().toLowerCase() ? "https:" : "http:"
    }
    function u(b, c, g) {
        return t(b) + "//" + (g.google_remarketing_only ? "googleads.g.doubleclick.net" : g.google_conversion_domain || "www.googleadservices.com") + "/pagead/" + c
    }

    function v() {
        var b = w,
            c = navigator,
            g = document,
            a = w,
            d = "/?";
        "landing" == a.google_conversion_type && (d = "/extclk?");
        var d = u(b, [a.google_remarketing_only ? "viewthroughconversion/" : "conversion/", j(a.google_conversion_id), d, "random=", j(a.google_conversion_time)].join(""), a),
            e;
        a: {
            e = a.google_conversion_language;
            if (e != f) {
                e = e.toString();
                if (2 == e.length) {
                    e = k("hl", e);
                    break a
                }
                if (5 == e.length) {
                    e = k("hl", e.substring(0, 2)) + k("gl", e.substring(3, 5));
                    break a
                }
            }
            e = ""
        }
        c = [k("cv", a.google_conversion_js_version), k("fst", a.google_conversion_first_time),
        k("num", a.google_conversion_snippets), k("fmt", a.google_conversion_format), k("value", a.google_conversion_value), k("label", a.google_conversion_label), k("oid", a.google_conversion_order_id), k("bg", a.google_conversion_color), e, k("guid", "ON"), k("disvt", a.google_disable_viewthrough), k("is_call", a.google_is_call), p(a), q(b, c, a.google_conversion_date), r(b, g, a.google_conversion_page_url), m(a), a.google_remarketing_for_search && !a.google_conversion_domain ? "&srr=n" : ""].join("");
        c = d + c;
        g = function (a, b, c) {
            return '<img height="' + c + '" width="' + b + '" border="0" src="' + a + '" />'
        };
        return 0 == a.google_conversion_format && a.google_conversion_domain == f ? '<a href="' + (t(b) + "//services.google.com/sitestats/" + ({
            ar: 1,
            bg: 1,
            cs: 1,
            da: 1,
            de: 1,
            el: 1,
            en_AU: 1,
            en_US: 1,
            en_GB: 1,
            es: 1,
            et: 1,
            fi: 1,
            fr: 1,
            hi: 1,
            hr: 1,
            hu: 1,
            id: 1,
            is: 1,
            it: 1,
            iw: 1,
            ja: 1,
            ko: 1,
            lt: 1,
            nl: 1,
            no: 1,
            pl: 1,
            pt_BR: 1,
            pt_PT: 1,
            ro: 1,
            ru: 1,
            sk: 1,
            sl: 1,
            sr: 1,
            sv: 1,
            th: 1,
            tl: 1,
            tr: 1,
            vi: 1,
            zh_CN: 1,
            zh_TW: 1
        }[a.google_conversion_language] ? a.google_conversion_language + ".html" : "en_US.html") + "?cid=" + j(a.google_conversion_id)) +
            '" target="_blank">' + g(c, 135, 27) + "</a>" : 1 < a.google_conversion_snippets || 3 == a.google_conversion_format ? g(c, 1, 1) : '<iframe name="google_conversion_frame" width="' + (2 == a.google_conversion_format ? 200 : 300) + '" height="' + (2 == a.google_conversion_format ? 26 : 13) + '" src="' + c + '" frameborder="0" marginwidth="0" marginheight="0" vspace="0" hspace="0" allowtransparency="true" scrolling="no">' + g(c.replace(/\?random=/, "?frame=0&random="), 1, 1) + "</iframe>"
    }
    function x() {
        return new Image
    };
    var w = window;
    if (w) if (/[\?&;]google_debug/.exec(document.URL) != f) {
        var y = w,
            z = document.getElementsByTagName("head")[0];
        z || (z = document.createElement("head"), document.getElementsByTagName("html")[0].insertBefore(z, document.getElementsByTagName("body")[0]));
        var A = document.createElement("script");
        A.src = u(window, "conversion_debug_overlay.js", y);
        z.appendChild(A)
    } else {
        try {
            var B;
            var C = w;
            "landing" == C.google_conversion_type || !C.google_conversion_id || C.google_remarketing_only && C.google_disable_viewthrough ? B = !1 : (C.google_conversion_date = new Date, C.google_conversion_time = C.google_conversion_date.getTime(), C.google_conversion_snippets = "number" == typeof C.google_conversion_snippets && 0 < C.google_conversion_snippets ? C.google_conversion_snippets + 1 : 1, "number" != typeof C.google_conversion_first_time && (C.google_conversion_first_time = C.google_conversion_time), C.google_conversion_js_version = "7", 0 != C.google_conversion_format && (1 != C.google_conversion_format && 2 != C.google_conversion_format && 3 != C.google_conversion_format) && (C.google_conversion_format = 1), B = !0);
            if (B && (document.write(v()), w.google_remarketing_for_search && !w.google_conversion_domain)) {
                var D = w,
                    E, F = w,
                    G;
                G = t(F) + "//www.google.com/ads/user-lists/" + [j(D.google_conversion_id), "/?random=", Math.floor(1E9 * Math.random())].join("");
                E = G += [k("label", D.google_conversion_label), k("fmt", "3"), r(F, document, D.google_conversion_page_url)].join("");
                var H = x;
                "function" === typeof D.opt_image_generator && (H = D.opt_image_generator);
                var I = H();
                E += k("async", "1");
                I.src = E;
                I.onload = function () {}
            }
        } catch (J) {}
        for (var K = w, M = 0; M < h.length; M++) K[h[M]] = f
    };
})();