$(window).load(function(){
	
var RaceCanvas = Backbone.View.extend({
    el: '#race-canvas',
    YOHAKU_UE: 50,
    YOHAKU: 20,
    HANKEI: 150,
    STRAIT: 350,
    ctx: null,
    
    initialize: function(){
        this.ctx = this.el.getContext('2d');
        this.collection.on("sync", this.render, this);
    },
    
    render: function(collection, models) {
        this.ctx.clearRect(0, 0, this.el.width, this.el.height);
        this.drawTrac();
        this.drawProgress(models);
    },
    
    drawTrac: function() {
        this.ctx.beginPath();
        this.ctx.arc(this.HANKEI + this.YOHAKU, this.HANKEI + this.YOHAKU_UE, this.HANKEI, 0.5 * Math.PI, 1.5 * Math.PI, false);
        this.ctx.lineTo(this.YOHAKU + this.HANKEI + this.STRAIT, this.YOHAKU_UE);
        this.ctx.arc(this.YOHAKU + this.HANKEI + this.STRAIT, this.HANKEI + this.YOHAKU_UE, this.HANKEI, -0.5 * Math.PI, 0.5 * Math.PI, false);
        this.ctx.lineTo(this.YOHAKU + this.HANKEI + this.STRAIT, this.YOHAKU_UE + this.HANKEI * 2);
        this.ctx.closePath();
        this.ctx.fillStyle = '#FFFFF0';
        this.ctx.fill();
        this.ctx.stroke();
        this.ctx.moveTo(this.HANKEI + this.YOHAKU, this.YOHAKU_UE - 10);
        this.ctx.lineTo(this.HANKEI + this.YOHAKU, this.YOHAKU_UE + 10);
        this.ctx.closePath();
        this.ctx.fill();
        this.ctx.stroke();
        this.ctx.font = "120% Sans-Serif";
        this.ctx.textAlign = 'center';
        this.ctx.strokeText('Start', this.HANKEI + this.YOHAKU, this.YOHAKU_UE - 25);
        this.ctx.moveTo(this.HANKEI + this.YOHAKU, this.YOHAKU_UE + this.HANKEI * 2 - 10);
        this.ctx.lineTo(this.HANKEI + this.YOHAKU, this.YOHAKU_UE + this.HANKEI * 2 + 10);
        this.ctx.closePath();
        this.ctx.fill();
        this.ctx.stroke();
        this.ctx.font = "120% Sans-Serif";
        this.ctx.textAlign = 'center';
        this.ctx.strokeText('Goal', this.HANKEI + this.YOHAKU, this.YOHAKU_UE + this.HANKEI * 2 - 25);
    },

    drawProgress: function(horses) {
        var denominator, horse, limitLen, totalLen,
            _this = this;
        horse = horses[0];
        totalLen = this.STRAIT * 2 + Math.PI * this.HANKEI;
        if (horse.numOfProgs) {
            limitLen = totalLen * (horse.pointOfProgs / horse.numOfProgs);
        } else {
            limitLen = totalLen;
        }
        denominator = horse.point;
        return _.each(horses, function(horse) {
            var arcLen, deg, img, len, rad, x, y, _x, _y;
            if (denominator) {
                len = (horse.point / denominator) * limitLen;
            } else {
                len = 0;
            }
            if (len <= _this.STRAIT) {
                x = _this.YOHAKU + _this.HANKEI + len;
                y = _this.YOHAKU_UE - 2;
            } else if (len <= _this.STRAIT + Math.PI * _this.HANKEI) {
                arcLen = len - _this.STRAIT;
                deg = (arcLen / (Math.PI * _this.HANKEI)) * 180.0;
                rad = deg * Math.PI / 180.0;
                _x = Math.sin(rad) * _this.HANKEI;
                x = _x + _this.YOHAKU + _this.HANKEI + _this.STRAIT;
                _y = Math.cos(rad) * _this.HANKEI;
                if (_y < 0) {
                    y = _y * -1 + _this.HANKEI + _this.YOHAKU_UE - 2;
                } else {
                    y = (_this.HANKEI - _y) + _this.YOHAKU_UE - 2;
                }
            } else {
                x = (_this.YOHAKU + _this.HANKEI + _this.STRAIT) - (len - _this.STRAIT - Math.PI * _this.HANKEI);
                y = _this.HANKEI * 2 + _this.YOHAKU_UE - 2;
            }
            img = new Image();
            img.src = horse.book.small_image_url;
            return img.onload = function() {
                var rectHeight = 18;
                _this.ctx.beginPath();
                _this.ctx.rect(x, y - rectHeight, img.width, rectHeight);
                _this.ctx.fillStyle = horse.color.background_color;
                _this.ctx.fill();
                _this.ctx.font = "90% Sans-Serif";
                _this.ctx.strokeStyle = horse.color.text_color;
                _this.ctx.textAlign = 'center';
                _this.ctx.strokeText(horse.horseNo, x + img.width / 2, y - rectHeight + 12);
                return _this.ctx.drawImage(img, x, y);
            };
        });
    }
});

/**
 * RaceProgressに必要な設定項目
 * @type {{raceId: (*|jQuery), raceUrl: string, progressUrl: string, responseTime: number}}
 */
var RaceProgressConfig = {
    raceId: $("#race_id").val(),
    raceUrl: '/race/'+ $("#race_id").val() +'.json',
    progressUrl: '/race/'+ $("#race_id").val() +'/progresses/current.json',
    responseTime: 3000
};

/**
 * Progress Model
 * @type {*|void}
 */
var RaceProgress = Backbone.Model.extend({});

/**
 * Progress Collection
 * @type {*|void}
 */
var RaceProgresses = Backbone.Collection.extend({
    model: RaceProgress,
    url: RaceProgressConfig.progressUrl
});

/**
 * 順位表示のView
 * @type {*|void}
 */
var ProgressRankingList = Backbone.View.extend({
    el: $('#ranking-list'),
    initialize: function(){
        this.collection.on("sync", this.render, this);
    },
    render: function(collection) {
    	var _createHtml = '';
    	var select_horse = $('#select_horse').length ? $('#select_horse').val() : 0;
        collection.each(function(model) {
        	var horse = model.attributes;
        	if(horse.horseNo == 1) horse.color.background_color = '#DDD';
        	//リストの色づけ
        	var borderStyle = 'style="border:3px solid '+ horse.color.background_color +'"';
        	var style = 'style="color:'+horse.color.text_color+';background:'+ horse.color.background_color +'"';
        	//ランキングリストの生成
        	_createHtml += '<dl id="race_rank'+ horse.order +'" '+ borderStyle +' horse-id="'+ horse.id +'" class="cf">';
        	if(select_horse == horse.id)
        		_createHtml += '<span class="select_horse" horse-id="'+ horse.id +'">投票</span>';
        	_createHtml += '<dt '+ style +'>'+ horse.order +'位</dt>';
        	_createHtml += '<dd>'+ horse.book.title +'</dd>';
        	_createHtml += '</dl>';
        });
        this.$el.html(_createHtml);
    }
});

if($("#race-canvas").length) {	
	var progresses = new RaceProgresses();
	var raceCanvas = new RaceCanvas({collection: progresses});
	var progressRankingList  = new ProgressRankingList({collection: progresses});
	
	progresses.fetch();	
	
	setInterval(function(){
		$.get(RaceProgressConfig.raceUrl, function(race) {
			if (race.state === 'RUNNING') {
				progresses.fetch();				
			} else if(race.state === 'READY'){
				progresses.fetch();	
			} else if(race.state === 'END') {
				$('#race_state').val('END');
				$('#race-paint').hide();
				$('#race-modes-end').show();
				$('#race_king').text($('#race_rank1').find('dd').text());
			}
		});
	}, RaceProgressConfig.responseTime);
};

});

