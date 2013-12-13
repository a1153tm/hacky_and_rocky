/**
 * marqueeを流すためのクラス
 * ---------使い方---------
 * maruqee = new RaceProgress("#test");
 * marquee.send("何かしら文字");
 * 
 * @param element クラス名やID名など
 * @constructor
 */
function RaceProgressMarquee(element) {
    this.element = element;
    this.text = null;
}

/**
 * marqueeを実際に流す際の実行メソッド。
 * @param {String} text (流す文字)
 * @return void
 * @access public
 */
RaceProgressMarquee.prototype.send = function(text) {
    this.text = text;
    if(this._validate() === true) {
        this._sendMarquee();
    } else {
        //validateがエラーだった時の処理。
        //@TODO ここは何かしら改変していただけると助かります。
        alert('文字が空白です');
    }
};

/**
 * marqueeを 生成する。
 * @return void
 * @private
 */
RaceProgressMarquee.prototype._sendMarquee = function() {
    var results = '<marquee behavior="scroll" loop="1" style="top:'+ this._marqueePosition() +'px" scrollamount="'+ this._marqueeSpeed() +'" direction="left">'+ this._htmlSpecialChars() +'</marquee>';
    $(this.element).append(results);
};

/**
 * marqueeで流す文字をescapeする。
 * @return String (escapeした文字)
 * @private
 */
RaceProgressMarquee.prototype._htmlSpecialChars = function() {
    return this.text.replace(/&/g, "&amp;").replace(/"/g, "&quot;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
};

/**
 * 発言する文字数が、１文字以下、４２文字以上の場合は発言を禁止する。
 * @return boolean
 */
RaceProgressMarquee.prototype._validate = function() {
    if(this.text.length > 0 && this.text.length < 39) return true;
    return false;
};

/**
 * marqueeの流す文字位置(高さ)を設定する。
 * @return integer positionY
 * @private
 */
RaceProgressMarquee.prototype._marqueePosition = function() {
    var positionY = 0;
    var marqueeSize = $(this.element).find('marquee').size();
    var textHeight = 20;
    if(marqueeSize % textHeight === 0) {
        positionY = 0;
    } else {
        positionY = (marqueeSize % textHeight) * textHeight;
    }
    return positionY;
};

/**
 * marqueeの流すスピードを設定する。
 * (数字が大きい方が速い)
 * @return integer
 */
RaceProgressMarquee.prototype._marqueeSpeed = function() {
    var textLength = this.text.length;
    switch (textLength) {
        case textLength > 41 :
            return 30;
            break;
        case textLength > 36 && textLength < 40 :
            return 25;
            break;
        case textLength > 31 && textLength < 35 :
            return 20;
            break;
        case textLength > 14 && textLength < 30 :
            return 15;
            break;
        default :
            return 10;
    };
};