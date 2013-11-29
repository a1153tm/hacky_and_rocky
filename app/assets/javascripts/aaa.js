var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  $(function() {
    var RaceCanvas, canvas, _ref;
    canvas = document.getElementById('race-canvas');
    if (!canvas) {
      return;
    }
    return RaceCanvas = (function(_super) {
      __extends(RaceCanvas, _super);

      function RaceCanvas() {
        _ref = RaceCanvas.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      RaceCanvas.prototype.el = '#race-canvas';

      RaceCanvas.prototype.initialize = function() {
        this.collection.on('sync', this.render);
        this.ctx = this.el.getContext('2d');
        this.YOHAKU_UE = 50;
        this.YOHAKU = 20;
        this.HANKEI = 150;
        return this.STRAIT = 350;
      };

      RaceCanvas.prototype.render = function(collection) {
        this.ctx.clearRect(0, 0, this.el.width, this.el.height);
        this.drawTrac();
        return this.drawProgress(collection);
      };

      RaceCanvas.prototype.drawTrac = function() {
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
        this.ctx.strokeText('繧ｹ繧ｿ繝ｼ繝', this.HANKEI + this.YOHAKU, this.YOHAKU_UE - 20);
        this.ctx.moveTo(this.HANKEI + this.YOHAKU, this.YOHAKU_UE + this.HANKEI * 2 - 10);
        this.ctx.lineTo(this.HANKEI + this.YOHAKU, this.YOHAKU_UE + this.HANKEI * 2 + 10);
        this.ctx.closePath();
        this.ctx.fill();
        this.ctx.stroke();
        this.ctx.font = "120% Sans-Serif";
        this.ctx.textAlign = 'center';
        return this.ctx.strokeText('繧ｴ繝ｼ繝ｫ', this.HANKEI + this.YOHAKU, this.YOHAKU_UE + this.HANKEI * 2 - 30);
      };

      RaceCanvas.prototype.drawProgress = function(horses) {
        var denominator, horse, limitLen, totalLen,
          _this = this;
        horse = horses[0];
        totalLen = this.STRAIT * 2 + Math.PI * this.HANKEI;
        if (horse.get('numOfProgs')) {
          limitLen = totalLen * (horse.get('pointOfProgs') / horse.get('numOfProgs'));
        } else {
          limitLen = totalLen;
        }
        denominator = horse.get('point');
        return _.each(horses, function(horse) {
          var arcLen, deg, img, len, rad, x, y, _x, _y;
          if (denominator) {
            len = (horse.get('point') / denominator) * limitLen;
          } else {
            len = 0;
          }
          if (len <= _this.STRAIT) {
            x = _this.YOHAKU + _this.HANKEI + len;
            y = _this.YOHAKU_UE - 20;
          } else if (len <= _this.STRAIT + Math.PI * _this.HANKEI) {
            arcLen = len - _this.STRAIT;
            deg = (arcLen / (Math.PI * _this.HANKEI)) * 180.0;
            rad = deg * Math.PI / 180.0;
            _x = Math.sin(rad) * _this.HANKEI;
            x = _x + _this.YOHAKU + _this.HANKEI + _this.STRAIT;
            _y = Math.cos(rad) * _this.HANKEI;
            if (_y < 0) {
              y = _y * -1 + _this.HANKEI + _this.YOHAKU_UE;
            } else {
              y = (_this.HANKEI - _y) + _this.YOHAKU_UE;
            }
          } else {
            x = (_this.YOHAKU + _this.HANKEI + _this.STRAIT) - (len - _this.STRAIT - Math.PI * _this.HANKEI);
            y = _this.HANKEI * 2 + _this.YOHAKU_UE;
          }
          img = new Image();
          img.src = horse.get('book').small_image_url;
          return img.onload = function() {
            return _this.ctx.drawImage(img, x, y);
          };
        });
      };

      return RaceCanvas;

    })(Backbone.View);
  });
