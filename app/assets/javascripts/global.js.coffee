$ ->
  # modify the behavior of .navbar-fixed-top to hide banner image
  $nav = $('.navbar-fixed-top')
  offset = 90
  $(window).scroll ->
    top = $(@).scrollTop()
    if top >= offset
      $nav.css('top', offset * -1)
    else
      $nav.css('top', top * -1)

  # hack for in-page anchor link issue of .navbar-fixed-top
  # see https://github.com/twitter/bootstrap/issues/1768
  # TODO this code can't process direct accesses with anchor from other page
  shiftWindow = -> scrollBy(0, -50)
  window.addEventListener("hashchange", shiftWindow)

  $('#sidenav').affix {
    offset: {
      top: 90,
      bottom: 91
    }
  }
