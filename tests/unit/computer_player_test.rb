require 'minitest'
require 'minitest/autorun'
require_relative '../../app/models/player'
require_relative '../../app/models/computer_player'

class ComputerPlayerTest < MiniTest::Test

def test_human_player_is_a_player
  player = ComputerPlayer.new("Hal")
  assert_kind_of Player, player
end

def test_player_has_mark
  player = ComputerPlayer.new("player")
  player.mark = TicTacToe::CROSS
  assert_equal TicTacToe::CROSS, player.mark
end

def test_player_is_line_aware
  player = ComputerPlayer.new("player")
  assert_kind_of LineAware, player
end

def test_player_can_choose_winning_move
  player = ComputerPlayer.new("player")
  player.mark = TicTacToe::CROSS
  assert_equal 6, player.choose_move("X OXO    ")
end

def test_player_can_block_winning_move_by_other_player
  player = ComputerPlayer.new("player")
  player.mark = TicTacToe::NOUGHT
  assert_equal 6, player.choose_move("X OXO    ")
end

def test_player_can_pick_the_only_empty_space
  player = ComputerPlayer.new("player")
  player.mark = TicTacToe::CROSS
  move = player.choose_move("O XXOOOXX")
  assert_equal 1, move, "#{move} is not an empty position"
end

def test_player_can_given_a_choice_pick_an_empty_space
  player = ComputerPlayer.new("player")
  player.mark = TicTacToe::CROSS
  move = player.choose_move("OXO X XOX")
  assert [3,5].include?(move), "#{move} is not an empty position"
end

def test_player_to_s_returns_right_number
  player1 = ComputerPlayer.new("player1")
  player1.mark = TicTacToe::CROSS
  assert_equal "player1", player1.to_s

  player2 = ComputerPlayer.new("player2")
  player2.mark = TicTacToe::NOUGHT
  assert_equal "player2", player2.to_s
end

def test_opening_play_is_in_a_corner_or_center
  player = ComputerPlayer.new("player")
  player.mark = TicTacToe::CROSS
  move = player.choose_move("         ")
  assert [0,2,4,6,8].include?(move), "#{move} is not where it should be"
end

def test_second_player_first_move_is_in_centre_if_available
  player = ComputerPlayer.new("player2")
  player.mark = TicTacToe::NOUGHT
  move = player.choose_move("X        ")
  assert_equal 4 ,move, "#{move} is not where it should be"
end

def test_force_win_if_available
  player = ComputerPlayer.new("player2")
  player.mark = TicTacToe::CROSS
  move = player.choose_move("XO  X   O")
  assert [3,6].include?(move), "#{move} is not where it should be"
end

end