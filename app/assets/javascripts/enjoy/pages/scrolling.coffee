window.enjoy_cms.pages.scrolling_menu_for = ( menu_selector = "#main_menu",
                                              menu_item_selector = "#main_menu a",
                                              header_height = 100,
                                              px_per_ms = 4,
                                              set_block_to_center = true,
                                              time_for_animate = 1000)->
  $(window).scroll ->
    y = $(this).scrollTop()
    $(menu_item_selector).each (event) ->
      _target = $($(this).attr('href'))
      if set_block_to_center
        _target_position = _target.offset().top - ($(window).height() / 2)
      else
        _target_position = _target.offset().top

      _target_position = 0 if _target_position < 0
      if _target.length > 0 and y >= _target_position - header_height
        $(menu_item_selector).not(this).removeClass 'active'
        $(this).addClass 'active'


  $(document).delegate menu_item_selector, 'click', (e)->
    e.preventDefault()
    _menu = $(e.currentTarget)
    window.history.pushState({}, (document.title = _menu.data('history-title')), e.currentTarget.href)

    if location.pathname.replace(/^\//, '') == @pathname.replace(/^\//, '') and location.hostname == @hostname
      target = $(@hash)
      target = if target.length then target else $('[name=' + @hash.slice(1) + ']')
      target = if target.length then target else $(_menu.data('pageblock-selector'))

      if target.length > 0
        if px_per_ms and px_per_ms  > 0
          if set_block_to_center
            target_top = target.offset().top - ($(window).height() / 2) + header_height
          else
            target_top = target.offset().top + header_height

          current_top = window.scrollY
          animate_length = Math.abs(target_top - current_top)
          time_for_animate = animate_length / px_per_ms

        $('html,body').animate { scrollTop: target_top }, time_for_animate
    return false



  load = ->
    if window.location.hash
      $(menu_item_selector).filter("[href='" + window.location.hash + "']").click()

  $(window).load ->
    load()
  $(document).bind "page:load", ->
    load()
