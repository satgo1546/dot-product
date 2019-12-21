// ==UserScript==
// @name         辣鸡移氚刷题非完全辅助功能
// @namespace    Spicy Chicken Moving Tritium
// @version      0.05
// @description  允许大部分辣鸡移氚的题完全使用键盘作答。
// @author       Frog Chen
// @match        http://www.jiangpingyc.pte.sh.cn/*
// @run-at       document-idle
// @grant        none
// ==/UserScript==

/*
	【使用说明】
	这个东西解决了我一用电脑做题就手疼的问题（？
	不支持作为Chromium系浏览器原生的扩展安装。建议的安装步骤如下：
		1. 安装扩展程序Tampermonkey。
		2. 在Tampermonkey中，新建脚本。
		3. 用本脚本的所有内容替换Tampermonkey提供的空脚本模板。
		4. 保存。
		5. 刷新所有已打开的做题页面。版式应当已被更改且可使用键盘按键。
	Firefox（应该）也可以使用Greasemonkey，但我没有测试过。
	这样在刷题页面里可以使用下列按键：
		A/B/C/D/1/2/3/4 = 选择
			※ 不支持综合题。
		S = 保存
		P = 提交
		←/→ = 上一题/下一题
			※ 此按键和Page Up/Page Down在原始页面中也有效。
		W = 查看整卷
			※ 查看整卷后将不能使用本脚本提供的功能。
		Y/N = 部分对话框的选择
	作弊功能：
		F3 = 显示答案
		F4 = 得到整张卷子的答案（仅限选择题）
		F7 = 全自动抄答案
		T = 修改已用/剩余时间（实验性；仅在不刷新的情况下有效）
	※ 目前键盘操作仅支持逐题答，且不支持综合题。
	然后顺便调整了题目界面的版（yán）面（sè），以及关闭了切题时的动画效果。
	※ 本脚本没有任何担保。作者不能负责任何因使用本脚本而产生的问题。
*/

(function () {
	'use strict';

	function long_string(f) {
		var t = f.toString().split("\n");
		t.pop();
		t.shift();
		return t.join("\n");
	}

	var style_common = long_string(function () { /*
		.ctl {
			font-family: SimSun;
			color: black !important;
			background-color: white;
			cursor: default;
			border: 2px outset #ddd;
			padding: 1px 6px;
			display: inline-block;
			line-height: 24px;
		}

		.ctl:active {
			background-color: #aaa;
			border-style: inset;
		}
	*/ });

	var url_exam = 'http://www.jiangpingyc.pte.sh.cn/my/exam';
	var style_exam = style_common + long_string(function () { /*
		body, #pageContent {
			background-color: white;
			background-image: none;
		}

		.exam_toolbar, #pageContent > nav, .glyphicon, #slide canvas.annotation, #slide img.annotation, .fancybox-bg {
			display: none;
		}

		::-webkit-scrollbar-thumb, ::-webkit-scrollbar-track {
			background-color: initial;
		}

		.question.exam {
			border-radius: 0px !important;
		}

		#paper_nav div.question.exam.status_being.current {
			border: 1px solid black;
			color: navy;
			background: aliceblue;
		}

		div#slideContainer, .ui-resizable-handle {
			height: initial !important;
		}

		div#paper_nav {
			width: 30px !important;
			height: initial !important;
			background: tan;
			border-left: 2px solid tan;
		}

		.clock_timer {
			background-color: transparent;
			color: black;
			font-size: 100%;
		}

		#divToolbar {
			padding-left: 0;
		}

		.exam .knowledge {
			display: inline;
		}

		.msgGrowl.success {
			display: none !important;
		}

		#slide .slides > div, .question .order_no div {
			background: none;
		}

		.status_being {
			border-left-style: none;
		}

		span.xzt {
			border-bottom-style: none;
			font-size: 200%;
			background-color: beige;
		}

		.fade {
			transition: initial;
		}

		#btnPrev {
			display: inline-block !important;
		}

		#btnPrev[style*=none] {
			visibility: hidden;
		}
	*/ });

	var url_task = 'http://www.jiangpingyc.pte.sh.cn/my/task';
	var style_task = style_common + long_string(function () { /*
	*/ });

	function add_style(css) {
		var el = document.createElement('style');
		el.innerHTML = css;
		document.body.appendChild(el);
	}

	function element_ready(id, callback) {
		if (document.getElementById(id)) {
			callback();
		} else {
			window.console.log('Waiting for #' + id);
			window.setTimeout(function () {
				element_ready(id, callback);
			}, 100);
		}
	}

	function ctl(el, text, key) {
		el.removeClass().addClass('ctl');
		el.attr('title', '');
		el.text(text);
		el.append('(<u>' + key + '</u>)');
	}

	$.fx.off = true;

	if (window.location.href.slice(0, url_exam.length) == url_exam) {
		add_style(style_exam);
		element_ready('_slide_menu', function () {
			if ($('#p_maintitle:visible').length > 0) return;

			var breadcrumb = $('.breadcrumb').first();
			var add_breadcrumb_item = function (child) {
				breadcrumb.append($('<li></li>').add(child));
			};
			var ctl_next = $('#btnNext > a');
			var ctl_prev = $('#btnPrev > a');
			var ctl_save = $('#btnSaveExam');
			var ctl_submit = ctl_save.parent().next().children('button:first');
			var ctl_whole = $('.navbar-header a[target]:only-child');
			ctl(ctl_next, '下一题', '→');
			ctl(ctl_prev, '上一题', '←');
			ctl(ctl_save, '保存', 'S');
			ctl(ctl_submit, '提交', 'P');
			ctl(ctl_whole, '显示全卷', 'W');
			$('#_wPaint_menu, #_slide_menu').remove();
			$(document).off('keyup');
			$(document).keydown(function (event) {
				switch (event.which) {
					case 37: // ←
						ctl_prev.click();
						break;
					case 39: // →
						ctl_next.click();
						break;
					case 83: // S
						ctl_save.click();
						break;
					case 80: // P
						ctl_submit.click();
						break;
					case 87: // W
						window.location.href = ctl_whole.attr('href');
						break;
					case 49: case 50: case 51: case 52: // 1/2/3/4
					case 65: case 66: case 67: case 68: // A/B/C/D
					case 97: case 98: case 99: case 100: // Num 1/2/3/4
						var choice = $('#divMain > div:visible:first span.xzt');
						choice.click();
						var value = event.which;
						if (value < 60) value += 16;
						if (value > 90) value -= 32;
						choice.next().find('a[value=' + String.fromCharCode(value) + ']').click();
						break;
					case 114: // F3
						var a = '';
						$('.xzt:visible').each(function () {
							a += $(this).attr('answer');
						});
						window.alert(a);
						event.preventDefault();
						break;
					case 115: // F4
						var b = '';
						$('.xzt').each(function (i) {
							if (i % 5 === 0) b += ' ';
							b += $(this).attr('answer');
						});
						b = b.slice(1);
						window.prompt('', b);
						break;
					case 118: // F7
						if (!window.confirm('警告：这将失去做题的乐趣。（？）')) break;
						$('.question:first').click();
						var auto_answer = function () {
							window.setTimeout(function () {
								window.event = {}; // 某段垃圾代码不加这个会报错
								var xzt = $('#divMain > div:visible:first span.xzt');
								xzt.click();
								xzt.next().find('a[value=' + xzt.attr('answer') + ']').click();
								if (ctl_next.is(':visible')) {
									window.setTimeout(function () {
										ctl_next.click();
										auto_answer();
									}, 50);
								}
							}, 50);
						};
						auto_answer();
						break;
					case 84: // T
						var timer = $('.clock_timer:first');
						var s = window.prompt('s', timer.attr('s'));
						if (s !== '') {
							var ss = parseInt(s);
							var ok = true;
							if (ss <= 0 && timer.attr('t') !== '+') ok = window.confirm('警告：1秒后将自动交卷。');
							if (ok) timer.attr('s', ss);
						}
						break;
					case 89: // Y
						$('a[value=yes]:visible:first').click();
						break;
					case 78: // N
						$('a[value=no]:visible:first').click();
						break;
					default:
						window.console.log('Ignored key press: ' + event.which);
				}
			});
			ctl_submit.click(function () {
				window.setTimeout(function () {
					ctl($('#fancyConfirm a[value=yes]'), '是', 'Y');
					ctl($('#fancyConfirm a[value=no]'), '否', 'N');
				}, 50);
			});
			breadcrumb.css('padding', '0');
			add_breadcrumb_item(ctl_whole);
			$('span.xzt:empty').text('·');
			document.title = $('#p_maintitle').text();
			$('a[onclick="expandQuestion(this)"]').click();
		});
	} else if (window.location.href.slice(0, url_task.length) == url_task) {
		add_style(style_task);
		element_ready('frmContainer', function () {
		});
	}
})();
