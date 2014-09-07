class State
  constructor: ->
    @bindClicks()

  loadCurrent: ->
    if @currentPath().length is 0
      @loadNewState()
    else
      @loadGraph()

  bindClicks: ->
    $('body').on 'click', '.directory-item', @onFileClick

  currentPath: ->
    decodeURIComponent(
      window.location.hash.substring(1, window.location.hash.length)
    ).replace /^(\/)/, ''

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
    $.get("/nodes/sidebar", path: @currentPath()).then (html) =>
      $("#Sidebar").replaceWith(html)
      @loadGraph()

  loadFileList: ->
    $.get("/nodes/file_list", path: @currentPath()).then (html) ->
      $("#FileList").replaceWith(html)

  loadGraph: ->
    $.get("/nodes/stats.json", path: @currentPath()).then (data) ->
      seriesData = []
      for own type, size of data.category_stats
        seriesData.push [type, size]

      $("#UsageChart").highcharts
        title:
          text: 'Usage by Type'
        series: [{
          type: 'pie'
          name: 'Size'
          data: seriesData
        }]

state = new State()
state.loadCurrent()
