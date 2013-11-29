$(window).load(function(){
/**
 * RaceProgressに必要な設定項目
 * @type {{raceId: (*|jQuery), raceUrl: string, progressUrl: string, responseTime: number}}
 */
var RaceProgressConfig = {
    raceId: $("#race_id").val(),
    raceUrl: '/race/'+ $("#race_id").val() +'.json',
    progressUrl: '/race/'+ $("#race_id").val() +'/progresses/current.json',
    responseTime: 10000
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
    el: $('#rank-list'),
    initialize: function(){
        this.collection.on("sync", this.render);
    },
    render: function(collection) {
    	var _createHtml = '';
        collection.each(function(model) {
        	_createHtml += '<dl class="cf">';
        	_createHtml += '<dt>'+ model.attributes.order +'</dt>';
        	_createHtml += '<dd>'+ model.attributes.book.title +'</dd>';
        	_createHtml += '</dl>';
        });
        this.el.html(_createHtml);
    }
});

var progresses = new RaceProgresses();
var raceCanvas = new RaceCanvas({collection: progresses});
var progressRankingList  = new ProgressRankingList({collection: progresses});
//初めにフェッチをする。
progresses.fetch();	
setInterval(function(){
	$.get(RaceProgressConfig.raceUrl, function(race) {
		if (race.state === 'RUNNING') {
			progresses.fetch();				
		} else if(race.state === 'READY'){
			
		} else if(race.state === 'END') {
		}
	});
}, RaceProgressConfig.responseTime);

});