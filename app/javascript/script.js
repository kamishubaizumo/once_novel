// ターボリンクが原因で、正常にスクリプトが動かないバグを修正するには、
//"turbolinks:load"の中にスクリプトを書く。
document.addEventListener("turbolinks:load", function() {
  // 処理内容


	/*global $*/$(function(){
			$("#back a").on("click",function(event){
				$("body, html").animate({
					scrollTop: 0,
				}, 400);
				event.preventDefault();//aタグのリンク機能の無効化
			});
		});




		$(function(){
			$(".menu-trigger").on("click",function(event){
				$(this).toggleClass("active");
				$("#sp-menu").fadeToggle();
				event.preventDefault();
			});
	});
})









