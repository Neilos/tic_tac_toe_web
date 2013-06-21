require 'minitest'
require 'minitest/autorun'
require '../lib/player'
require '../lib/human_player'

class HumanPlayerTest < MiniTest::Test

def test_human_player_is_a_player
  player = HumanPlayer.new("human")
  assert_kind_of Player, player
end

end