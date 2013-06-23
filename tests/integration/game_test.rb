require 'minitest'
require 'minitest/autorun'
require 'rack/test'
require 'ostruct'
require_relative '../../app/controllers/game'


class GameTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Game.new
  end

  def test_root
    get '/', :player1 =>'ted', :player2 =>'jim'
    assert last_response.ok?
    refute_nil rack_mock_session.cookie_jar["rack.session"]
    assert_includes last_response.body, 'Tic Tac Toe'
    assert_includes last_response.body, '<table id="board">'
    assert_includes last_response.body, '<table id="players_table">'
    assert_includes last_response.body, '<input id="player1_name" name="player1_name"'
    assert_includes last_response.body, '<input id="player1_name" name="player1_name"'
    assert_includes last_response.body, '<p id="game_instructions">'
    assert_includes last_response.body, '<input type="submit" class="board_rubber" value="New Game"/>'
  end

  def test_nextmove_when_game_over_returns_correct_response
    post '/nextmove', :board => 'XOXOXOXOX'
    assert last_response.ok?
    assert_includes last_response.body, 'game_instructions'
    assert_includes last_response.body, '"game_state":"game_over"'
    assert_includes last_response.body, 'next_player_mark'
    assert_includes last_response.body, '"board":"XOXOXOXOX"'
  end

  def test_nextmove_when_game_in_progress_returns_correct_response
    post '/nextmove', :board => 'XX   OO  '
    assert last_response.ok?
    assert_includes last_response.body, 'game_instructions'
    assert_includes last_response.body, '"game_state":"in_progress"'
    assert_includes last_response.body, '"next_player_mark":"X'
    assert_includes last_response.body, '"board":"XX   OO  "'
  end


end
