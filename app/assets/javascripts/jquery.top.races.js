$(window).load(function(){
	
	//
	//	レースリストの各項目の高さを揃える。
	//	レースリストの一番右側の列の余白を０にする。
	//------------------------------------------------------------------------------
	var count = 1;
	var divisor = 4;
	$('#races-list .list dl').tile();
	$('#races-list .list dl').each(function(){
		if(count % divisor === 0) $(this).css('margin-right','0px');
		count++;
	});
	
	//
	//	レースリストのタブ切り替え
	//-----------------------------------------------------------------------------
	$('#race-list-menu').find('li').click(function(){
		var list_id = '#' + $(this).attr('data-id');
		$('#race-list-menu').find('li').removeClass('active');
		$('#race-list-content').find('div').hide();
		$(this).addClass('active');
		$(list_id).show();
	});
	
	//
	//	【画面読み込み時】トップ画面レースリストの、詳細リストデータを格納する。
	//------------------------------------------------------------------------------
	$('.race_id_list').each(function() {
		var race_id = $(this).val();
		var url = '/race/'+ race_id +'/?format=json';
		var result_html = '';
		$.getJSON(url, function(horses){
			result_html += '<div id="race_'+ race_id +'" style="display:none">';
			for(key in horses) {
				var horse = horses[key];
				result_html += '<dl>';
				result_html += '<dt>';
				result_html += '<a href="'+ horse.book.item_url +'" target="_blank">';
				result_html += '<img src="'+ horse.book.small_image_url +'" alt="'+ horse.book.title +'" />';
				result_html += '</a>';
				result_html += '</dt>';
				result_html += '<dd>';
				result_html += '<a href="'+ horse.book.item_url +'" target="_blank">';
				result_html += horse.book.title;
				result_html += '</a>';
				result_html += '</dd>';
				result_html += '</dl>';
			}
			result_html += '</div>';
			race_dialog.find('.race-dialog-contents').append(result_html);
		});
	});	
	
	//
	//	レースリストに、詳細ダイヤログを表示させる。
	//------------------------------------------------------------------------------
	var race_dialog = $('#race-list-dialog');
	$('#races-list .list > div > dl').hover(function() {
		var race_id = $(this).attr('data-id');
		var position = $(this).offset();
		var index = $(this).index() + 1;
		
		race_dialog.show();
		$("#race_" + race_id).show();
		position.top += -50 ;
		if(index % 4 == 1 || index % 4 === 2) {
			position.left += 225;
		} else {
			position.left -= 610;
		}
		race_dialog.css(position);
	}, function() {
		race_dialog.find('.race-dialog-contents').find('div').hide();
		race_dialog.hide();
	});
});