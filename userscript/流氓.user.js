// ==UserScript==
// @name         流氓
// @namespace    http://satgo1546.mist.so/
// @version      0.0
// @description  在此填写描述
// @author       satgo1546
// @include      *
// @grant        none
// ==/UserScript==

(function() {

var el, s, i;

// 屏蔽复制事件
// 我就是来抄袭的，怎么着？
document.addEventListener("copy", function (event) {
	event.stopPropagation();
}, true);

// 询问meta refresh
if (el = document.querySelector("meta[http-equiv=\"refresh\"]")) {
	s = el.getAttribute("content");
	i = parseInt(s);
	if (i > 1 && i <= 5) {
		s = s.slice(s.indexOf("=") + 1);
		el.remove();
		if (prompt("<meta http-equiv=\"refresh\" content=", s)) {
			window.location.href = s;
		}
	}
}

})();
