JEX =
  common: init: ->
    $('[data-close]').on 'click', ->
      $(this).parent().slideUp(200)
      return
    return
  visitors:
    init: ->
      return
    index: ->
      return

UTIL =
  exec: (controller, action) ->
    `var action`
    ns = JEX
    action = if action == undefined then 'init' else action
    if controller != '' and ns[controller] and typeof ns[controller][action] == 'function'
      ns[controller][action]()
    return
  init: ->
    body = document.body
    controller = body.getAttribute('data-controller')
    action = body.getAttribute('data-action')
    UTIL.exec 'common'
    UTIL.exec controller
    UTIL.exec controller, action
    return

$(document).ready UTIL.init