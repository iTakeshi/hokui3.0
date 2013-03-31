$ ->
  $nav = $('.navbar-fixed-top')
  offset = 90

  $(window).scroll ->
    top = $(@).scrollTop()
    if top >= offset
      $nav.css('top', offset * -1)
    else
      $nav.css('top', top * -1)
