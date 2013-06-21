require 'minitest'
require 'minitest/autorun'
require_relative '../lib/player'

class PersonTest < MiniTest::Test

def test_player_has_mark
  player = Player.new("player")
  player.mark = TicTacToe::CROSS
  assert_equal TicTacToe::CROSS, player.mark
end

def test_player_is_line_aware
  player = Player.new("player")
  assert_kind_of LineAware, player
end

def test_to_s
  player = Player.new("player_me")
  assert_equal "player_me", player.to_s
end

def test_choose_move
  player = Player.new("player")
  assert_raises(NotImplementedError) { player.choose_move('         ') }
end

end