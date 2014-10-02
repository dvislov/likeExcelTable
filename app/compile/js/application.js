(function() {
  $(document).ready(function() {
    var initTableFirstColumn, initTableFirstHeader, scrollPane, srcTableWrap;
    srcTableWrap = $("#excel_table");
    scrollPane = srcTableWrap.bind('jsp-scroll-x', function(event, scrollPositionX, isAtLeft, isAtRight) {
      return $('.freeze-table-left-wrap').css({
        left: scrollPositionX
      });
    }).bind('jsp-scroll-y', function(event, scrollPositionY, isAtTop, isAtBottom) {
      return $('.freeze-table-top-wrap').css({
        top: scrollPositionY
      });
    }).jScrollPane();
    initTableFirstHeader = function() {
      $('table.table:first').clone().addClass('freeze-table-top').appendTo('.table-wrap');
      $('.freeze-table-top').wrap('<div class="freeze-table-top-wrap"></div>');
      return $('.freeze-table-top-wrap').css({
        height: $('table.table:first thead').height()
      });
    };
    initTableFirstColumn = function() {
      var columnBorderWidth, columnWidth;
      $('table.table:first').clone().addClass('freeze-table-left').appendTo('.table-wrap');
      $('.freeze-table-left').wrap('<div class="freeze-table-left-wrap"></div>');
      columnBorderWidth = parseInt($('table.table:first tbody tr:first td:first').css("borderWidth"));
      columnWidth = parseInt($('table.table:first thead th:first').outerWidth());
      return $('.freeze-table-left-wrap').css({
        width: columnWidth + columnBorderWidth + "px"
      });
    };
    initTableFirstColumn();
    return initTableFirstHeader();
  });

}).call(this);
