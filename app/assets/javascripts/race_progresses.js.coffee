# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  #-----------------------------------------------------------------------------
  # For comment post
  #-----------------------------------------------------------------------------
  #$('#new_comment').bind 'ajax:success', (data, res, xhr) ->
  #  $('#race-comments .read').html(res)
  #  $('#comment_comment').val('')

  #-----------------------------------------------------------------------------
  # For race canvas
  #-----------------------------------------------------------------------------
  canvas = document.getElementById('race-canvas')
  return unless canvas;
  
  class RaceCanvas extends Backbone.View
    el: '#race-canvas'

    initialize: ->
      @collection.on('sync', @render)
      @ctx = @el.getContext('2d')
      @YOHAKU_UE = 50
      @YOHAKU = 20
      @HANKEI = 150
      @STRAIT = 350

    render: (collection) ->
      @ctx.clearRect(0, 0, @el.width, @el.height);
      @drawTrac()
      @drawProgress(collection)
  
    drawTrac: ->
      # Stroke track
      @ctx.beginPath()
      @ctx.arc(@HANKEI + @YOHAKU, @HANKEI + @YOHAKU_UE, @HANKEI, 0.5 * Math.PI, 1.5 * Math.PI, false)
      @ctx.lineTo(@YOHAKU + @HANKEI + @STRAIT, @YOHAKU_UE)
      @ctx.arc(@YOHAKU + @HANKEI + @STRAIT, @HANKEI + @YOHAKU_UE, @HANKEI, -0.5 * Math.PI, 0.5 * Math.PI, false)
      @ctx.lineTo(@YOHAKU + @HANKEI + @STRAIT, @YOHAKU_UE + @HANKEI * 2)
      @ctx.closePath()
      @ctx.fillStyle = '#FFFFF0'
      @ctx.fill()
      @ctx.stroke()
    
      # Mark start
      @ctx.moveTo(@HANKEI + @YOHAKU, @YOHAKU_UE - 10)
      @ctx.lineTo(@HANKEI + @YOHAKU, @YOHAKU_UE + 10)
      @ctx.closePath()
      @ctx.fill()
      @ctx.stroke()
      @ctx.font = "120% Sans-Serif"
      @ctx.textAlign = 'center'
      @ctx.strokeText('スタート', @HANKEI + @YOHAKU, @YOHAKU_UE - 20)
    
      # Mark goal
      @ctx.moveTo(@HANKEI + @YOHAKU, @YOHAKU_UE + @HANKEI * 2 - 10)
      @ctx.lineTo(@HANKEI + @YOHAKU, @YOHAKU_UE + @HANKEI * 2 + 10)
      @ctx.closePath()
      @ctx.fill()
      @ctx.stroke()
      @ctx.font = "120% Sans-Serif"
      @ctx.textAlign = 'center'
      @ctx.strokeText('ゴール', @HANKEI + @YOHAKU, @YOHAKU_UE + @HANKEI * 2 - 30)
    
    drawProgress: (horses) ->
      horse = horses[0]
      totalLen = @STRAIT * 2 + Math.PI * @HANKEI
      if horse.get('numOfProgs')
        limitLen = totalLen * (horse.get('pointOfProgs') / horse.get('numOfProgs'))
      else
        limitLen = totalLen
  
      denominator = horse.get('point')
      _.each horses, (horse) =>
        #console.log horse
        if denominator
          len = (horse.get('point') / denominator) * limitLen
        else
          len = 0
        if len <= @STRAIT
          x = @YOHAKU + @HANKEI + len
          y = @YOHAKU_UE - 20
        else if len <= @STRAIT + Math.PI * @HANKEI
          arcLen = len - @STRAIT
          deg = (arcLen / (Math.PI * @HANKEI)) * 180.0
          rad = deg * Math.PI / 180.0 
          _x = Math.sin(rad) * @HANKEI
          x = _x + @YOHAKU + @HANKEI + @STRAIT
          _y = Math.cos(rad) * @HANKEI
          if _y < 0
            y = _y * -1 + @HANKEI + @YOHAKU_UE
          else
            y = (@HANKEI - _y) + @YOHAKU_UE
        else
          x = (@YOHAKU + @HANKEI + @STRAIT) - (len - @STRAIT - Math.PI * @HANKEI)
          y = @HANKEI * 2 + @YOHAKU_UE
  
        img = new Image()
        img.src = horse.get('book').small_image_url
        img.onload = =>
          @ctx.drawImage(img, x, y)
  
  #raceCanvas = new RaceCanvas()
  #$.getJSON "#{location.pathname}", (horses) ->
  #  raceCanvas.render(horses)

