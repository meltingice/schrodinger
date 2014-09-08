class Wait
  constructor: ->
    @ping()

  ping: =>
    $.get('/user.json')
      .then (user) =>
        if user.account_ready
          $(".progress .meter").css width: "100%"
          @redirect()
        else
          progress = user.total_size / (user.quota.shared + user.quota.normal) * 100
          $(".progress .meter").css width: "#{progress}%"
          setTimeout(@ping, 2000)
      .fail =>
        setTimeout(@ping, 5000)

  redirect: -> window.location.href = '/stats'

new Wait()
