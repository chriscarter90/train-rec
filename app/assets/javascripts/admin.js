//= require jquery
//= require foundation
//= require jquery.dataTables.min

$( function() {

    // define maximum characters for a table cell
    var maxChar = 60;

    $.each($('td'), function( index, value ) {
      var text = $(this).text();

      if (text.length > maxChar) {
        // to avoid cutting off a sentence in the middle of a wor
        // we need to find the last space char before the maxChar
        // and use that as the last char to slice on
        var lastChar = text.slice(0, maxChar).lastIndexOf(" ")


        var limited = "<div class='text'>" +text.slice(0, lastChar)+"</div> ";
        limited += "<a class='more'>more</a> ";
        limited += "<div class='less'>"+text.slice(lastChar, text.length) +"</div>";
        limited += "<a class='less'>less</a> ";
        $(this).html(limited)
      }
    })

    function expand(el) {
      el.parent().find('.less').show();
      el.parent().find('.more').hide();
    }

    function contract(el) {
      el.parent().find('.more').show();
      el.parent().find('.less').hide();     
    }

    $('.less').click( function() {
      contract( $(this) );
    })

    $('.text').click( function() {
      expand( $(this) );
    })

    $('.more').click( function() {
      expand( $(this) );
    })


    if ($('#datatable').length > 0) {
      $('#datatable').dataTable(
        { 
          "aLengthMenu": [
              [25, 50, 100, 200, -1],
              [25, 50, 100, 200, "All"]
          ], 
          "iDisplayLength" : -1 
        }
      );
    }
});

