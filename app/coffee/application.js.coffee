$(document).ready ->

  srcTableWrap = $("#excel_table")

  scrollPane = srcTableWrap
    .bind 'jsp-scroll-x', (event, scrollPositionX, isAtLeft, isAtRight) ->
      $('.freeze-table-left-wrap').css
        left: scrollPositionX
    .bind 'jsp-scroll-y', (event, scrollPositionY, isAtTop, isAtBottom) ->
      $('.freeze-table-top-wrap').css
        top: scrollPositionY
    .jScrollPane()



  initTableFirstHeader = ->
    $('table.table:first').clone().addClass('freeze-table-top').appendTo('.table-wrap')

    $('.freeze-table-top').wrap('<div class="freeze-table-top-wrap"></div>')
    $('.freeze-table-top-wrap').css
      height: $('table.table:first thead').height()

  initTableFirstColumn = ->
    $('table.table:first').clone().addClass('freeze-table-left').appendTo('.table-wrap')
    $('.freeze-table-left').wrap('<div class="freeze-table-left-wrap"></div>')

    columnBorderWidth = parseInt($('table.table:first tbody tr:first td:first').css("borderWidth"))
    columnWidth = parseInt($('table.table:first thead th:first').outerWidth())

    $('.freeze-table-left-wrap').css
      width: columnWidth + columnBorderWidth + "px"

  initTableFirstColumn()
  initTableFirstHeader()
