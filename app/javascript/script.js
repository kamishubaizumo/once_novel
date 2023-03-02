// なぜか挙動がバグってスクロールしない

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










