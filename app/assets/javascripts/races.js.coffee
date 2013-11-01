# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  class ItemView extends Backbone.View
    events:
      'change .require': 'changed'

    initialize: ->
      @$label = @$el.children('label')
      @$select = @$el.children('select')

    changed: ->
      if result = checkSelects()
        size = 0
        _.each result, (e) -> size += 1
        updateAll(3 - size)
      else
        @$select.val('')

    val: ->
      @$el.children('select').val()

    updateLabelOfRemain: (remain) ->
      @$label.text("あと#{remain}つ")
      @$label.removeClass('valid-ok')
      @$label.removeClass('valid-none')
      @$label.addClass('valid-message')
      @$select.removeAttr("disabled")

    updateLabelToNone: ->
      @$label.text('ＯＫ')
      @$label.removeClass('valid-message')
      if @val()
        @$label.addClass('valid-ok')
      else
        @$label.addClass('valid-none')
        @$select.attr("disabled", "disabled")

  voteItems = []
  $('.vote_item').each ->
    item = new ItemView({el: $(@)})
    item.updateLabelOfRemain(3)
    voteItems.push item

  checkSelects = ->
    result = {}
    _.each voteItems, (item) ->
      val = item.val()
      if val
        if result[val]
          result[val] += 1
        else
          result[val] = 1
    res = true
    _.each result, (v,k) ->
      if v > 1
        alert '重複して登録することはできません'
        res = false
    if res
      result
    else
      null

  updateAll = (remain) ->
    if remain
      _.each voteItems, (item) -> item.updateLabelOfRemain(remain)
    else
      _.each voteItems, (item) -> item.updateLabelToNone()

  form = $('#vote-form')
  if form
    form.submit ->
      result = checkSelects()
      size = 0
      _.each result, (e) -> size += 1
      if size and result[10]
        true
      else
        alert '本命を１つ選択してください'
        false
