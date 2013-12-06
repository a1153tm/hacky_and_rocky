$(window).load(function(){

	//賭け金
	var wagarZeny = $('#vote_item_amount');

	//賭け金の表示
	var wagarDisplay = $('#wagar-display');

	//所持金
	var myZeny = $('#user_zeny').val();

	//残金の表示
	var remainingDisplay = $('#remaining-display');

	//ゼニーの表示をお金っぽくｗ
	var numberFormat = function(str) {
		return str.replace(/([0-9]+?)(?=(?:[0-9]{3})+$)/g , '$1,');	
	}

	//賭け金を変更したら、残りの残額等を表示させる。	
	wagarZeny.change(function() {
		var _remainingZeny = myZeny - $(this).val();
		wagarDisplay.text( numberFormat($(this).val()) );
		remainingDisplay.text( numberFormat(_remainingZeny.toString()) );
	});
	
});
