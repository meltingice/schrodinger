class State
  constructor: ->
    @bindClicks()

  bindClicks: ->
    $('body').on 'click', '.directory-item', @onFileClick

  currentPath: ->
    decodeURIComponent(window.location.hash.substring(1, window.location.hash.length))

  onFileClick: (e) =>
    $target = $(e.target)
    $target = $target.closest('.directory-item') unless $target.hasClass('directory-item')
    @setNewState $target

  setNewState: ($ele) ->
    window.location.hash = "##{encodeURIComponent($ele.data('path'))}"
    @loadNewState()

  loadNewState: ->
    @loadSidebar()
    @loadFileList()

  loadSidebar: ->
    $.get("/nodes/sidebar", path: @currentPath()).then (html) ->
      $("#Sidebar").replaceWith(html)

  loadFileList: ->
    $.get("/nodes/file_list", path: @currentPath()).then (html) ->
      $("#FileList").replaceWith(html)

new State()
