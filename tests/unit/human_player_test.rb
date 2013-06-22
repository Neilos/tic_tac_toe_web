require 'minitest'
require 'minitest/autorun'
require_relative '../../app/models/player'
require_relative '../../app/models/human_player'

class HumanPlayerTest < MiniTest::Test

def setup
  @player = HumanPlayer.new("human")
end

def test_human_player_is_a_player
  assert_kind_of Player, @player
end

def test_human_player_class_does_NOT_choose_a_move_thus_letting_actual_player_choose_the_move
  assert_nil @player.choose_move('         ')
end

end