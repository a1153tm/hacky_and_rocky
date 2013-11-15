# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#new_comment').bind 'ajax:success', (data, res, xhr) ->
    $('#race-comments .read').html(res)

  canvas = $('#race-canvas').get(0)
  ctx = canvas.getContext("2d")

  # Stroke track
  ctx.beginPath()
  ctx.arc(250, 250, 200, 0.5 * Math.PI, 1.5 * Math.PI, false)
  ctx.lineTo(750, 50)
  ctx.arc(750, 250, 200, -0.5 * Math.PI, 0.5 * Math.PI, false)
  ctx.lineTo(750, 450)
  ctx.closePath()
  ctx.fillStyle = '#FFFFF0'
  ctx.fill()
  ctx.stroke()

  # Mark start point
  ctx.moveTo(250, 40)
  ctx.lineTo(250, 60)
  ctx.closePath()
  ctx.fill()
  ctx.stroke()
  ctx.font = "120% Sans-Serif"
  ctx.textAlign = 'center'
  ctx.strokeText('スタート', 250, 30)

  # Mark goal point
  ctx.moveTo(250, 440)
  ctx.lineTo(250, 460)
  ctx.closePath()
  ctx.fill()
  ctx.stroke()
  ctx.font = "120% Sans-Serif"
  ctx.textAlign = 'center'
  ctx.strokeText('ゴール', 250, 480)

  # Map horses
  $.get "#{location.pathname}/race_horses", (horses) ->
    totalLen = 500 + Math.PI * 200 + 500
    limitLen = totalLen
    denominator = horses[0].point
    _.each (horse) ->
      len = (horse.point / denominator) * totalLen
      if len <= 500
        x = 250 + len
        y = 50
      else if len <= 500 + Math.PI * 200
        arcLen = len - 500
        #angle = ((Math.PI * 200) / arclen) * 180
        deg = arcLen / 200 * Math.PI
        rad = deg * Math.PI/ 180.0 
      else

      img = new Image()
      img.src = first.book.small_image_url
      console.log first.book.small_image_url
      img.onload = ->
        ctx.drawImage(img, 100, 200)

