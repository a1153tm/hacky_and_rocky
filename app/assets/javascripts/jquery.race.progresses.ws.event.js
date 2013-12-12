/**
 * レース経過ページのWebSocket関連の実行ファイル
 */
$(window).load(function(){
	if($('#marquee').length) {
		var host = 'ws://denka-ws.herokuapp.com/';
		var ws = new WebSocket(host);
		var wsMarquee = new RaceProgressMarquee('#marquee');
		var wsLog = new RaceProgressLog('#race-comment');
		var raceId = $('#race_id').val();
		var userName = $('#user_name').val();
		var comments = $("#comments");
		var values = $("#test");
		
		//webSocketの開始
		ws.onopen = function (){
			var message = {race_id: raceId, type: 'join'};
			ws.send(JSON.stringify(message));
		};
		
		//webSocketからデータが送られ、marqueeとlogを表示する。
		ws.onmessage = function (event){
			var getMessage = JSON.parse(event.data);
			wsMarquee.send(getMessage.comment);
			wsLog.send(getMessage.comment, getMessage.user_name);
		};
		
		//接続停止
		ws.onclose = function(event){
			console.log(ws.readyState);
		};
		
		//webSocketに、投稿内容の送信
		comments.submit(function(){
			if(values.val().length > 0){
			    var message = {race_id: raceId, type: 'post', user_name: userName, comment: values.val()};
			    ws.send(JSON.stringify(message));
				values.val("");
			} 
		});
	}
});