$ ->
  resize_iframe = ->
    $cal = $('#google-calendar')
    container_width = $cal.closest('div').width()
    $cal.attr('width', container_width)

  $(window).resize ->
    resize_iframe()

  resize_iframe()
