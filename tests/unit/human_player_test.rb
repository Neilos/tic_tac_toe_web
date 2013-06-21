require 'minitest'
require 'minitest/autorun'
require_relative '../../app/models/player'
require_relative '../../app/models/human_player'

class HumanPlayerTest < MiniTest::Test

def test_human_player_is_a_player
  player = HumanPlayer.new("human")
  assert_kind_of Player, player
end

end