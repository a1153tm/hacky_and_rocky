function RaceProgressLog(element) {
    this.element = element;
    this.text = null;
    this.name = null;
}

RaceProgressLog.prototype.send = function(text, name){
	this._set(text, name);
	if(this._validate()) this._add();
}

RaceProgressLog.prototype._validate = function(){
	if(this.text !== false && this.name !== false) return true;
	return false;
}

RaceProgressLog.prototype._set = function(text, name){
	this.text = typeof text !== 'undefined' ? text : null;
	this.name = typeof name !== 'undefined' ? name : null;
}

//logの追加
RaceProgressLog.prototype._add = function(){
	var results = '<dl>'; 
	results += '<dt>'+ this._htmlSpecialChars(this.text) +'</dt>';
	results += '<dd>'+ this._getCurrentTime() +'<p>by '+ this._htmlSpecialChars(this.name) +'</p></dd>';
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