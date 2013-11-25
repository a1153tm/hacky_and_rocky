# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  #-----------------------------------------------------------------------------
  # For comment post
  #-----------------------------------------------------------------------------
  $('#new_comment').bind 'ajax:success', (data, res, xhr) ->
    $('#race-comments .read').html(res)
    $('#comment_comment').val('')

  #-----------------------------------------------------------------------------
  # For race canvas
  #-----------------------------------------------------------------------------
  YOHAKU = 50
  HANKEI = 200
  STRAIT = 500

  canvas = $('#race-canvas').get(0)
  return unless canvas;
  ctx = canvas.getContext("2d")

  # Stroke track
  ctx.beginPath()
  ctx.arc(HANKEI + YOHAKU, HANKEI + YOHAKU, HANKEI, 0.5 * Math.PI, 1.5 * Math.PI, false)
  ctx.lineTo(YOHAKU + HANKEI + STRAIT, 50)
  ctx.arc(YOHAKU + HANKEI + STRAIT, HANKEI + YOHAKU, HANKEI, -0.5 * Math.PI, 0.5 * Math.PI, false)
  ctx.lineTo(YOHAKU + HANKEI + STRAIT, YOHAKU + HANKEI * 2)
  ctx.closePath()
  ctx.fillStyle = '#FFFFF0'
  ctx.fill()
  ctx.stroke()

  # Mark start
  ctx.moveTo(HANKEI + YOHAKU, YOHAKU - 10)
  ctx.lineTo(HANKEI + YOHAKU, YOHAKU + 10)
  ctx.closePath()
  ctx.fill()
  ctx.stroke()
  ctx.font = "120% Sans-Serif"
  ctx.textAlign = 'center'
  ctx.strokeText('スタート', HANKEI + YOHAKU, YOHAKU - 20)

  # Mark goal
  ctx.moveTo(HANKEI + YOHAKU, YOHAKU + HANKEI * 2 - 10)
  ctx.lineTo(HANKEI + YOHAKU, YOHAKU + HANKEI * 2 + 10)
  ctx.closePath()
  ctx.fill()
  ctx.stroke()
  ctx.font = "120% Sans-Serif"
  ctx.textAlign = 'center'
  ctx.strokeText('ゴール', HANKEI + YOHAKU, YOHAKU + HANKEI * 2 + 30)

  # Map horses
  $.getJSON "#{location.pathname}", (horses) ->
    totalLen = STRAIT * 2 + Math.PI * HANKEI
    limitLen = totalLen
    denominator = horses[0].point
    _.each horses, (horse) ->
      len = (horse.point / denominator) * totalLen
      if len <= STRAIT
        x = YOHAKU + HANKEI + len
        y = YOHAKU - 20
      else if len <= STRAIT + Math.PI * HANKEI
        arcLen = len - STRAIT
        deg = (arcLen / (Math.PI * HANKEI)) * 180.0
        rad = deg * Math.PI / 180.0 
        _x = Math.sin(rad) * HANKEI
        x = _x + YOHAKU + HANKEI + STRAIT
        _y = Math.cos(rad) * HANKEI
        if _y < 0
          y = _y * -1 + HANKEI + YOHAKU
        else
          y = (HANKEI - _y) + YOHAKU
      else
        x = (YOHAKU + HANKEI + STRAIT) - (len - STRAIT - Math.PI * HANKEI)
        y = HANKEI * 2 + YOHAKU

      img = new Image()
      img.src = horse.book.small_image_url
      img.onload = ->
        ctx.drawImage(img, x, y)


