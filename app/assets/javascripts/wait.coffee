class Wait
  constructor: ->
    @ping()

  ping: =>
    $.get('/user.json').then (user) =>
      if user.account_ready
        @redirect()
      else
        setTimeout(@ping, 2000)

  redirect: -> window.location.href = '/stats'

new Wait()
