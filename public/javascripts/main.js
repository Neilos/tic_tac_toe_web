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

function where_to_show_game_instructions() {
  // return $('div#game_instructions');
  true
}

function player_mark() {
  return 'X'
}

function set_board_values(new_values) {
  var new_values_array = new_values.split('');
  var table = board_squares();
  table.each(function(index) {
    $(this).text(new_values_array[index]);
  });
}

function show_game_instructions(instructions) {
  var placement = where_to_show_game_instructions();
  alert(instructions);
}


$(document).ready(function() {

  $('table#board').click(
    function(event) {
      var this_square = get_clicked_square(event);
      var board_values;
      if (empty_square(this_square)) {
        mark_square(this_square, player_mark());
        board_values = board_squares().text();
        $.post("/nextmove", {board: board_values, another: "parameter value"} ).done(
          function(data){ 
            var obj = jQuery.parseJSON( data );
            set_board_values(obj.board)
            show_game_instructions(obj.game_instructions)
          }
        )
      }
    }
  );
});