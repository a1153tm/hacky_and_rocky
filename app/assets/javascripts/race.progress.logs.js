function RaceProgressLog(element) {
    this.element = element;
    this.text = null;
    this.name = null;
}

//logの送信
RaceProgressLog.prototype.send = function(text, name){
	var results = '<dl>'; 
	results += '<dt>'+ this._htmlSpecialChars(text) +'</dt>';
	results += '<dd>'+ this._getCurrentTime() +'<p>by '+ this._htmlSpecialChars(name) +'</p></dd>';
	results += '</dl>';
	$(this.element).prepend(results);
}

//現在の時間を取得
RaceProgressLog.prototype._getCurrentTime = function(){
	var now   = new Date();
	var year  = now.getYear() < 2000 ? now.getYear() + 1900 : now.getYear();
	var month = now.getMonth() + 1;
	var day   = now.getDate();
	var hour  = now.getHours();
	var min   = now.getMinutes() < 10 ? '0' + now.getMinutes() : now.getMinutes();
	return year +'/'+ month +'/'+ day +' '+ hour +':'+ min
}

//Escape
RaceProgressLog.prototype._htmlSpecialChars = function(text) {
    return text.replace(/&/g, "&amp;").replace(/"/g, "&quot;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
};