class State
  constructor: ->
    @bindClicks()

  bindClicks: ->
    $('body').on 'click', '.directory-item', @onFileClick

  currentPath: ->
    decodeURIComponent(
      window.location.pathname.match(/\/stats\/(.*)/)[1]
    )

  onFileClick: (e) =>
    $target = $(e.target)
    $target = $target.closest('.directory-item') unless $target.hasClass('directory-item')
    @setNewState $target

  setNewState: ($ele) ->
    window.history.replaceState({}, 'Schrodinger', "/stats/#{@encodePath($ele.data('path'))}")
    @loadNewState()

  encodePath: (path) ->
    path.split('/').map (p) ->
      encodeURIComponent(p)
    .join('/')

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

new State()
