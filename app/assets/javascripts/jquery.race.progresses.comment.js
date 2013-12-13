/**
 * レース経過ページ
 * レースモードのコメント表示・非表示の切り替え関連 
 */
$(window).load(function(){
	if($('#race-modes-tabs').length) {
		
		//レースモードのタブ
		$('#race-modes-tabs').find('a').click(function(){
			var listId = '#'+$(this).attr('data-id');
			$('#race-modes-tabs').find('a').removeClass('active');
			$('#race-modes-list').find('div').hide();
			$(listId).show();
			$(this).addClass('active');
		});
		
		//コメントの表示・非表示切り替え
		$('#comment-display').click(function(){
			if($(this).hasClass('show')){
				$(this).removeClass('show').addClass('hide');
				$(this).val('コメント表示');
				$('#marquee').hide();
			} else {
				$(this).removeClass('hide').addClass('show');
				$(this).val('コメント非表示');
				$('#marquee').html('');
				$('#marquee').show();
			}
		});
	}
});