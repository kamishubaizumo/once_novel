// なぜか挙動がバグってスクロールしない

/*global $*/$(function(){
	$("#back a").on("click",function(event){
		$("body, html").animate({
			scrollTop: 0,
		}, 400);
		event.preventDefault();//aタグのリンク機能の無効化
	});
});