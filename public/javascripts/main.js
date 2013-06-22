function mark_square(square) {
  square.text('N');
}

function empty_square(square) {
  return square.text() == ' ';
}

function get_clicked_square(target){
  if (target.is('td')) {
    return target;
  } else if (target.parents('td').length) {
    return target.parents('td:first');
  }
}

$(document).ready(

  function() {

    $('table#board').click(
      function(event) {
        var clicked_element = $(event.target);
        var this_square = get_clicked_square(clicked_element);
        
        if (empty_square(this_square)) {
          mark_square(this_square);
          var all_square_values = $('table#board td').text() || [];
          alert(all_square_values);
        }
      }
    );
  }

);