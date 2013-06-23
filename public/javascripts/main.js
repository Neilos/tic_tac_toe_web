function mark_square(square, mark) {
  square.text(mark);
}

function is_empty_square(square) {
  return square.text() == ' ';
}

function get_clicked_table_square(event){
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
  return $('#game_instructions');
}

function player_mark() {
  return $('input#player_mark').text() || 'X';
}

function set_player_mark(mark) {
  $('input#player_mark').text(mark);
}

function set_game_state(state) {
  $('input#game_state').text(state);
}

function is_game_over() {
  return $('input#game_state').text() == 'game_over';
}

function set_board_values(new_values) {
  var new_values_array = new_values.split('');
  var table = board_squares();
  table.each(function(index) {
    $(this).text(new_values_array[index]);
  });
}

function populate_players_table( json_object ) {
  $('#player1_name').text( json_object.player1_name );
  $('#player1_won').text( json_object.player1_won );
  $('#player1_lost').text( json_object.player1_lost );
  $('#player1_drawn').text( json_object.player1_drawn );
  $('#player2_name').text( json_object.player2_name );
  $('#player2_won').text( json_object.player2_won );
  $('#player2_lost').text( json_object.player2_lost );
  $('#player2_drawn').text( json_object.player2_drawn );
}

function show_game_instructions(instructions) {
  var placement = where_to_show_game_instructions();
  placement.text(instructions);
}

function get_data() {
  var data = {
    board: board_squares().text(),
    player1_name: $('#player1_name').val(),
    player1_won: $('#player1_won').text(),
    player1_lost: $('#player1_lost').text(),
    player1_drawn: $('#player1_drawn').text(),
    player2_name: $('#player2_name').val(),
    player2_won: $('#player2_won').text(),
    player2_lost: $('#player2_lost').text(),
    player2_drawn: $('#player2_drawn').text()
  }
  return data;
}

function post_board_values() {
  $.post("/nextmove", get_data()).done(
    function(data){ 
      var obj = jQuery.parseJSON( data );
      show_game_instructions( obj.game_instructions );
      set_board_values( obj.board );
      populate_players_table( obj );
      set_game_state( obj.game_state );
      set_player_mark( obj.next_player_mark );
    }
  )
}


$(document).ready(function() {

  $('table#board').click(
    function(event) {
      var this_square = get_clicked_table_square(event);
      if (is_empty_square(this_square) && !is_game_over()) {
        mark_square(this_square, player_mark());
        post_board_values();
      }
    }
  );
});