# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  canvas = $('#race-canvas').get(0)
  ctx = canvas.getContext("2d")
  #ctx.fillStyle = "red"
  #ctx.rect(0,0,300,300)
  #ctx.fill()
  #ctx.stroke()

  ctx.beginPath()
  #ctx.moveTo(0,0)
  ctx.arc(150, 150, 100, 0.5 * Math.PI, 1.5 * Math.PI, false)
  ctx.lineTo(450, 50)
  ctx.arc(450, 150, 100, -0.5 * Math.PI, 0.5 * Math.PI, false)
  ctx.lineTo(150, 250)
  ctx.closePath()
  ctx.fillStyle = '#FFFFF0'
  ctx.fill()
  ctx.stroke()

  # Mark start point
  ctx.moveTo(180, 35)
  ctx.lineTo(180, 65)
  ctx.closePath()
  ctx.fill()
  ctx.stroke()
  ctx.font = "120% Sans-Serif"
  ctx.textAlign = 'center'
  ctx.strokeText('スタート', 180, 30)

  # Mark start point
#  ctx.moveTo(180, 35)
#  ctx.lineTo(180, 65)
#  ctx.closePath()
#  ctx.fill()
#  ctx.stroke()
#  ctx.font = "120% Sans-Serif"
#  ctx.textAlign = 'center'
#  ctx.strokeText('スタート', 180, 30)


