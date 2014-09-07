class State
  constructor: ->
    @bindClicks()
    @loadGraph()
    window.onpopstate = @loadNewState

    @xhrPool = []
    $.ajaxSetup
      beforeSend: (xhr) =>
        @xhrPool.push xhr
      complete: (xhr) =>
        index = @xhrPool.indexOf(xhr)
        @xhrPool.splice(index, 1) if index > -1

  abortPendingRequests: ->
    for xhr in @xhrPool
      xhr.abort() if xhr?
      
    @xhrPool = []

  bindClicks: ->
    $('body').on 'click', '.directory-item', @onFileClick
    $('body').on 'click', '.breadcrumbs a', @onBreadcrumbClick

  currentPath: ->
    decodeURIComponent(
      window.location.pathname.match(/\/stats\/?(.*)/)[1]
    )

  onFileClick: (e) =>
    $target = $(e.target)
    $target = $target.closest('.directory-item') unless $target.hasClass('directory-item')
    return if $target.hasClass('file')

    @setNewState $target

  onBreadcrumbClick: (e) =>
    @setNewState $(e.target)

  setNewState: ($ele) ->
    window.history.pushState({}, 'Schrodinger', "/stats/#{@encodePath($ele.data('path'))}")
    @loadNewState()

  encodePath: (path) ->
    path.split('/').map (p) ->
      encodeURIComponent(p)
    .join('/')

  loadNewState: =>
    @abortPendingRequests()
    $.when(@loadBreadcrumbs(), @loadSidebar(), @loadFileList()).then ->
      $(document).foundation()

  loadBreadcrumbs: ->
    $.get("/nodes/breadcrumbs", path: @currentPath()).then (html) =>
      $("#Breadcrumbs").replaceWith(html)

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
          align: 'left'
          x: -10
          style:
            fontSize: '1.4375rem'
            fontWeight: 'bold'
        plotOptions:
          pie:
            animation: false
        tooltip:
          formatter: ->
            return "#{@point.name}: #{@y} bytes" if @y < 1024
            return "#{@point.name}: #{Math.round(@y / 1024)} KB" if @y < 1048576
            return "#{@point.name}: #{Math.round(@y / 1048576)} MB" if @y < 1073741824
            return "#{@point.name}: #{Math.round(@y / 1073741824)} GB"
        series: [{
          type: 'pie'
          name: 'Size'
          data: seriesData
        }]

new State()
