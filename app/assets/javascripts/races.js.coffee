# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  voteAmount = $('#vote_item_amount')
  voteSubmit = $('#submit_vote')

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
      true
