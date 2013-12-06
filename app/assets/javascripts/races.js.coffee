# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  voteAmount = $('#vote_item_amount')
  voteSubmit = $('#submit_vote')
  myAmount = $('#user_zeny')
  class ItemView extends Backbone.View
    events:
      'click': 'changed'

    initialize: ->
      @$label = @$el.children('label')
      @$select = @$el.children('select')

    changed: ->
      voteAmount.removeAttr("disabled")
      voteSubmit.removeAttr("disabled")

  $('.vote_item_radio').each ->
    view = new ItemView({el: $(@)})

  form = $('#vote-form')
  if form
    form.submit ->
      remainingAmount = parseInt(myAmount.val(), 10) - parseInt(voteAmount.val(), 10)
      if 0 >= remainingAmount
        alert('限度ゼニーを超えています！')
        return false
      else if 0 >= voteAmount.val()
        alert('0よりも大きいゼニーを賭けてください！')
        return false
      else
        if confirm '本当に投票しますか？'
          return true
        return false