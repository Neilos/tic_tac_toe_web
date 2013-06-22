function mark_square(square, mark) {
  square.text(mark);
}

function empty_square(square) {
  return square.text() == ' ';
}

function get_clicked_square(event){
  var target = $(event.target);
  if (target.is('td')) {
    return target;
  } else if (target.parents('td').length) {
    return target.parents('td:first');
  }
}

function board_squares() {
  return $('table#board td');
}

function player_mark() {
  return 'N'
}

function set_board_values(new_values) {
  var new_values_array = new_values.split('');
  var table_values = board_squares();
  table_values.each(function(index) {
    $(this).text(new_values_array[index]);
  });
}

$(document).ready(function() {

  $('table#board').click(
    function(event) {
      var this_square = get_clicked_square(event);
      var board_values = board_squares().text();
      if (empty_square(this_square)) {
        mark_square(this_square, player_mark());
        $.post("/nextmove", {board: board_values} ).done(
          function(data){ set_board_values(data) }
        )
      }
    }
  );
});