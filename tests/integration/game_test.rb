require 'minitest'
require 'minitest/autorun'
require_relative '../../app/controllers/game'
require 'rack/test'

class GameTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Game.new
  end

  def test_new_game
    skip
  end

  def test_root
    get '/'
    assert last_response.ok?
    assert_includes last_response.body, 'Tic Tac Toe'
    assert_includes last_response.body, '<table id="board">'
    assert_includes last_response.body, '<div id="game_instructions">'
  end

  def test_nextmove
    post '/nextmove', :board => 'XOXOXOXOX'
    assert last_response.ok?
    assert_equal 'XOXOXOXOX', last_response.body
  end


end
