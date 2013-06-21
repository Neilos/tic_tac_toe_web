require 'minitest'
require 'minitest/autorun'
require '../lib/tic_tac_toe'
require '../lib/human_player'

class TicTacToeTest < Minitest::Test

  # the board is represented as a string of rows, e.g.
  # X |   | X
  # ---------
  # 0 | 0 | X
  # ---------
  #   |   | 0
  #
  # is represented as "X X00X  0"
  #
  # A blank board is represented as an array with 9 spaces
  #
  # The board is valid if the difference between the number of Xs and 0s is 1 or less
  #
  # The first move is always a cross, so if, for example, a board is initialised with two crosses
  # and two noughts, you know the next move is a cross.

  def setup
    @player1 = Player.new("player1")
    @player2 = Player.new("player2")
  end

  def test_a_board_with_fewer_or_more_than_9_values_cannot_be_created
    assert_raises(RuntimeError) do
      TicTacToe.new("", @player1, @player2)   
    end
  end

  def test_a_board_with_two_Xs_and_one_0_is_valid?
    game = TicTacToe.new("X X   0  ", @player1, @player2)
    assert game.valid?
  end

  def test_a_board_with_three_0_and_one_X_is_invalid?
    game = TicTacToe.new(" 0 0 0X  ", @player1, @player2)
    refute game.valid?
  end

  def test_the_board_with_nine_blank_spaces_is_valid
    game = TicTacToe.new('         ', @player1, @player2)
    assert game.valid?
  end

  def test_to_s
    game = TicTacToe.new("X XOX0X0X", @player1, @player2)
    string_representation = "X XOX0X0X"
    assert_equal string_representation, game.to_s
  end

  def test_print
    game = TicTacToe.new("X XOX0X0X", @player1, @player2)
    print_output = "\n\n X |   | X \n-----------\n O | X | 0 \n-----------\n X | 0 | X \n"
    assert_equal print_output, game.game_table
  end

  def test_the_game_is_line_aware
    game = TicTacToe.new("X XOX0X0X", @player1, @player2)
    assert_kind_of LineAware, game
  end

  def test_the_game_with_a_horizontal_line_is_finished
    game = TicTacToe.new("XXX 0 0  ", @player1, @player2)
    assert game.valid?
    assert_equal true, game.game_won?
  end

  def test_the_game_with_a_vertical_line_is_finished
    game = TicTacToe.new('X 0X00X  ', @player1, @player2)
    assert game.valid?
    assert game.game_won?
  end

  def test_the_game_with_a_diagonal_line_is_finished
    game = TicTacToe.new("X  0X0  X", @player1, @player2)
    assert game.valid?
    assert game.game_won?
  end

  def test_the_game_with_a_diagonal_line_is_finished
    game = TicTacToe.new("XX0 0 0XX", @player1, @player2)
    assert game.valid?
    assert game.game_won?
  end

  def test_the_game_without_a_winner_is_not_finished
    game = TicTacToe.new("XX00XXX00", @player1, @player2)
    assert game.valid?
    assert !game.game_won?
  end

  def test_the_game_has_two_players
    game = TicTacToe.new("X 0X0    ", @player1, @player2)
    assert_kind_of Player, game.player1
    assert_kind_of Player, game.player2
  end

  def test_players_have_marks_when_the_game_starts
    game = TicTacToe.new("X 0X0    ", @player1, @player2)   
    game.player1.mark == TicTacToe::CROSS
    game.player2.mark == TicTacToe::NOUGHT
  end

  def test_the_game_knows_the_next_player
    game = TicTacToe.new("X 0X0    ", @player1, @player2)
    assert_equal game.player1, game.next_player # X is the first because we assume X started the game    
  end

  def test_the_game_that_is_one_step_from_winning_can_calculate_the_best_move
    game = TicTacToe.new("X 0X0    ", @player1, @player2)
    game.next_move! # 6 is the index in the grid, 0 to 8
    assert_equal "X 0X0 X  ", game.to_s 
  end

  def test_game_over_when_finished_or_all_cells_populated
    game = TicTacToe.new("XXX 0 0  ", @player1, @player2)
    assert_equal true, game.game_won?
    assert_equal true, game.game_over?

    game = TicTacToe.new("X0XXX00X0", @player1, @player2)
    assert_equal true, game.game_over?
  end

  def test_game_NOT_over_until_finished_or_all_cells_populated
    game = TicTacToe.new("X0XXX00X ", @player1, @player2)
    refute game.game_won?
    refute game.game_over?
  end
  
  def test_a_game_can_be_played
    game = TicTacToe.new("         ", @player1, @player2)
    game.play!
    assert game.game_over?
  end

  def test_a_game_knows_who_the_winner_is
    game = TicTacToe.new("X 0X0    ", @player1, @player2)
    game.play!
    assert @player1, game.winner
  end


end