$(".external").on 'click', '.show-more-info', ->
  $('body').animate
    scrollTop: $(".more-info:first").offset().top
  , 1000, 'swing'
