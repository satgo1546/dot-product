// ==UserScript==
// @name         脚痛大学选课非完全辅助功能
// @namespace    http://satgo1546.mist.so/
// @version      0.07
// @description  减弱装饰，增强选课。
// @author       satgo1546
// @match        *://i.sjtu.edu.cn/*
// @match        *://kbcx.sjtu.edu.cn/*
// @grant        none
// ==/UserScript==
/* eslint-env browser, jquery */

(function() {
	'use strict';
	console.info("载入「脚痛大学选课非完全辅助功能」" + GM.info.script.version);
	function match_url(head) {
		return window.location.href.indexOf(head) >= 0;
	}
	function long_string(f) {
		var t = f.toString().split("\n");
		t.pop();
		t.shift();
		return t.join("\n");
	}
	function add_style(css) {
		var el = document.createElement('style');
		// 你的important和我的important比一比，看看到底谁更important
		el.innerHTML = css.replace(/;/g, " !important;");
		document.body.appendChild(el);
	}

	$.fx.off = true;
	if (match_url("sjtu.edu.cn/xtgl/")) { // 系统管理（首页）
		add_style(long_string(function () { /*
			body {
				background-color: white;
				font-family: SimSun;
			}

            h1, h2, h3, h4, h5, h6, p, blockquote, pre, dl, ol, ul, fieldset, form, table, article, aside, details, figure, footer, header, nav, section {
				font-family: SimSun;
            }

			.top1 .logo_2 img {
				display: none;
			}

			.navbar-header .navbar-brand {
				width: unset;
			}

			#cdNav {
				height: unset;
				display: block;
			}

			.navbar-toggle .icon-bar+.icon-bar {
				margin-top: 4px;
			}

			.dropdown > ul.dropdown-menu {
				display: inline;
				position: static;
				box-shadow: none;
				border-style: none;
				float: unset;
			}

			.dropdown > ul.dropdown-menu > li {
				display: inline;
			}

			.dropdown > ul.dropdown-menu > li > a {
				display: inline;
				font-size: 11pt;
				padding: 0;
				line-height: 1;
			}

			.dropdown > a > .caret {
				display: none;
			}

			.dropdown > a {
				font-weight: bold;
				display: inline;
				position: static;
				font-size: 11pt;
				padding: 0;
				line-height: 1;
				color: black;
			}

			.dropdown > a:hover, .dropdown > a:focus, .dropdown > a:active {
				background-color: transparent;
				color: unset;
			}

			.dropdown {
				display: block;
				float: initial;
			}
		*/ }));
		// 离开此网站！
		// 系统一定不会保存我所做的更改。
		window.flag = false; // 全局变量，告辞
		var el = document.createElement("li");
		el.innerHTML = long_string(function () { /*
			<li class="dropdown">
				<a>附赠功能 <b class="caret"></b></a>
				<ul class="dropdown-menu">
					<li><a href="https://i.sjtu.edu.cn/jxzxjhgl/pyjhxxcx_cxPyjhxxIndex.html">培养计划查询</a></li>
					<li><a href="https://i.sjtu.edu.cn/jxzxjhgl/kcapjsgl_cxKcapjsxxIndex.html">课程安排教室查询</a></li>
				</ul>
			</li>
		*/ });
		$("#cdNav > ul:first").append(el);
		$("a[tabindex=\"-1\"][onclick]").removeAttr("tabindex");
	}
	if (match_url("sjtu.edu.cn/kbcx/")) { // 课表查询
		add_style(long_string(function () { /*
			.table-hover > tbody > tr:hover {
				background-color: unset;
			}

			td[id^="6-"]:empty, td[id^="7-"]:empty {
				display: none;
			}

			.pull-right > font > i {
				font-style: normal;
			}

			.timetable1 > tbody > tr:nth-of-type(2) > td {
				width: 18%;
			}
			.timetable1 > tbody > tr:nth-of-type(2) > td:nth-of-type(1), .timetable1 > tbody > tr:nth-of-type(2) > td:nth-of-type(2) {
				width: 5%;
			}
			.timetable1 > tbody > tr:nth-of-type(2) > td:nth-of-type(1) > span {
				display: none;
			}
			.timetable1 > tbody > tr:nth-of-type(2) > td:nth-of-type(1) {
				width: 5%;
			}
			.timetable1 > tbody > tr:nth-of-type(2) > td:nth-of-type(1n + 8) {
				display: none;
			}

			.timetable1 .festival {
				font-family: "Arial Narrow";
				font-weight: 300;
				font-style: normal;
			}

			.satgo-minitable {
				border: 1px solid black;
				float: right;
			}
			.satgo-minitable td {
				width: 8px;
				height: 8px;
				border: 1px solid silver;
				line-height: 1px;
			}

			.satgo-cell-div:not(.satgo-cell-div-confirmed) {
				color: saddlebrown;
				background-color: antiquewhite;
			}
			.satgo-cell-div:not(.satgo-cell-div-confirmed)::before {
				content: "〖待筛选〗";
				display: block;
				font-size: small;
				text-align: right;
			}
		*/ }));
		setTimeout(function () {
			$("#kbcong").click(); $("#kbcongform input[type=checkbox]").prop("checked", true); $("#kbcongok").click();
			$("#kbcong").click(); $("#kbcongform input[type=checkbox]").prop("checked", true); $("#kbcongok").click();
			$("[onclick=\"searchResult()\"").click(function() {
				setTimeout(function () {
					$("span.festival").each(function () {
						var el = $(this);
						el.text([undefined,
							"8:00~", "~9:40",
							"10:00~", "~11:40",
							"", "12:55~",
							"14:00~", "~15:40",
							"16:00~", "~17:40",
							"18:00~", "", "~20:20",
							"",
						][parseInt(el.text())]);
					});
					$("span.title").each(function () {
						var s = "";
						var el = $(this);
						var t = el.text();
						if (el.html().match(/color=.?blue/i)) {
							el.parent().addClass("satgo-cell-div-confirmed");
						};
						var notes = "";
						el.parent().parent().addClass("satgo-cell");
						el.parent().addClass("satgo-cell-div");
						// 课程名称
						// 时间地点教学班选课备注周学时总学时学分
						s += "<b>" + t + "</b><br>";
						el = el.next(); t = el.text().trim();
						// 时间
						s += "<small>" + t + "</small><br>"
						t = t.replace(/^\s*\(\d+-\d+节\)|周/g, "");
						var a = [];
						$.each(t.split(","), function (index, value) {
							var i = value.split("-");
							var j;
							if (i.length == 1) i[1] = i[0];
							if (i.length != 2) notes += value + "<br>";
							var odd = !!(i[1].match(/单/));
							var even = !!(i[1].match(/双/));
							i[0] = parseInt(i[0]);
							i[1] = parseInt(i[1]);
							for (j = i[0]; j <= i[1]; j++) {
								if (odd && (j % 2 == 1)) a[j] = true;
								if (even && (j % 2 == 0)) a[j] = true;
								if (!(odd || even)) a[j] = true;
							}
						});
						if (!a[18]) a[18] = false;
						t = "<table class=\"satgo-minitable\"><tr>";
						$.each(a, function (index, value) {
							if (!index) return;
							t += "<td style=\"background-color: ";
							t += value ? "black" : "white";
							t += " !important;\"></td>";
							if (index % 5 == 0) t += "</tr><tr>";
						});
						t += "</tr></table>";
						s += t;
						el = el.next(); t = el.text().trim();
						// 地点
						t = t.replace(/^闵行/, "");
						s += "<big>" + t + "</big><br>";
						el = el.next(); t = el.text().trim();
						// 教师（教师职称）
						s += "<span>" + t + "</span><br>";
						el = el.next(); t = el.text().trim();
						// 教学班
						s = "<tt>" + t + "</tt><br>" + s;
						el = el.next(); t = el.text().trim();
						// 考核方式
						el = el.next(); t = el.text().trim();
						// 备注
						if (t == "无") t = "";
						if (t.length) {
							notes += "※ " + t + "<br>";
						}
						el = el.next(); t = el.text().trim();
						// 课程学时组成
						el = el.next(); t = el.text().trim();
						// 周学时
						el = el.next(); t = el.text().trim();
						// 总学时
						el = el.next(); t = el.text().trim();
						// 学分
						s += "<small>" + notes + "</small>";
						el.parent().html(s);
					});
				}, 600);
			});
		}, 600);
	}
	if (match_url("sjtu.edu.cn/jxzxjhgl/")) { // 专业培养计划查询
		$("a[href=\"#profileX\"]").click(function () {
			// 切换到“修读要求”选项卡时全部展开
			var f = function () {
				var more = $(".more");
				if (more.length) {
					more.each(function () {
						if (this.innerHTML.match(/（0[门条]/)) {
						} else {
							$(this).click();
						}
					});
				} else {
					setTimeout(f, 1000);
				}
			}
			f();
		}).append("<small> 会卡一会</small>")
	}
	if (match_url("sjtu.edu.cn/xsxk/")) { // 学生选课
		add_style(long_string(function () { /*
			body, #footerID {
				font-family: SimSun;
			}

			.table-hover > tbody > tr:hover {
				background-color: unset;
			}

			.top2 {
				display: none;
			}

			.outer {
				position: static;
				overflow: unset;
				width: unset;
				height: unset;
			}

			.outer_left {
				display: none;
				width: unset;
				height: unset;
			}

			.outer_right {
				position: static;
				overflow: unset;
				width: unset;
				height: unset;
			}

			.outer_left_xkxx:hover, .outer_left:hover .outer_left_xkxx {
				background-color: #981111;
			}

			.tjxk_list > .panel {
				margin-bottom: 0;
			}

			.tjxk_list > .panel .panel-title{
				padding-top: 10px;
				padding-bottom: 10px;
			}

			.nodata span {
				background-image: none;
				color: #d9edf7;
			}

			#tjkbtable, #xskbtable {
				font-size: 9pt;
			}

			.sats-alert {
				display: block;
				position: fixed;
				width: 100%;
				z-index: 9999;
				background-color: rgba(252, 248, 227, 0.67);
				text-align: center;
				font-size: 12pt;
				text-shadow: -1px -1px #fcf8e3, -1px 1px #fcf8e3, 1px -1px #fcf8e3, 1px 1px #fcf8e3;
				padding: 0.25em 10%;
			}
		*/ }));
		$(".sl_nav_tabs > li:first > a").click();
		setInterval(function () {
			$("a[onclick=\"loadCoursesByPaged();\"]:visible").click();
			$(".outer_left").click();
			$(".mCustomScrollbar").mCustomScrollbar("destroy");
		}, 600);
		// 干掉模态弹窗
		$.alert = function (a) {
			var el = $("<mark class=\"sats-alert\">" + a.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;") + "</mark>");
			el.prependTo($(document.body));
			setTimeout(function () {
				el.remove();
			}, 1700);
		}
	}
})();
