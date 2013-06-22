require 'minitest'
require 'minitest/autorun'
require_relative '../../app/controllers/game'
require 'rack/test'

class GameTest < Minitest::Test
  include Rack::Test::Methods
  # def setup
  # end

  def app
    Game.new
  end

  def test_root
    get '/'
    assert last_response.ok?
    assert_includes last_response.body, 'Tic Tac Toe'
    assert_includes last_response.body, '<table class="board">'
  end


end
