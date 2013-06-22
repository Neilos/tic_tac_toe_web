require 'minitest'
require 'minitest/autorun'
require_relative '../../app/models/tic_tac_toe'
require_relative '../../app/models/human_player'
require 'mocha/setup'

class TicTacToeTest < Minitest::Test

  # the board is represented as a string of rows, e.g.
  # X |   | X
  # ---------
  # O | O | X
  # ---------
  #   |   | O
  #
  # is represented as "X XOOX  O"
  #
  # A blank board is represented as an array with 9 spaces
  #
  # The board is valid if the difference between the number of Xs and Os is 1 or less
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

  def test_a_board_with_two_Xs_and_one_O_is_valid?
    game = TicTacToe.new("X X   O  ", @player1, @player2)
    assert game.valid?
  end

  def test_a_board_with_three_O_and_one_X_is_invalid?
    game = TicTacToe.new(" O O OX  ", @player1, @player2)
    refute game.valid?
  end

  def test_the_board_with_nine_blank_spaces_is_valid
    game = TicTacToe.new('         ', @player1, @player2)
    assert game.valid?
  end

  def test_to_s
    game = TicTacToe.new("X XOXOXOX", @player1, @player2)
    string_representation = "X XOXOXOX"
    assert_equal string_representation, game.to_s
  end

  def test_the_game_is_line_aware
    game = TicTacToe.new("X XOXOXOX", @player1, @player2)
    assert_kind_of LineAware, game
  end

  def test_the_game_with_a_horizontal_line_is_finished
    game = TicTacToe.new("XXX O O  ", @player1, @player2)
    assert game.valid?
    assert_equal true, game.game_won?
  end

  def test_the_game_with_a_vertical_line_is_finished
    game = TicTacToe.new('X OXOOX  ', @player1, @player2)
    assert game.valid?
    assert game.game_won?
  end

  def test_the_game_with_a_diagonal_line_is_finished
    game = TicTacToe.new("X  OXO  X", @player1, @player2)
    assert game.valid?
    assert game.game_won?
  end

  def test_the_game_with_a_diagonal_line_is_finished
    game = TicTacToe.new("XXO O OXX", @player1, @player2)
    assert game.valid?
    assert game.game_won?
  end

  def test_the_game_without_a_winner_is_not_finished
    game = TicTacToe.new("XXOOXXXOO", @player1, @player2)
    assert game.valid?
    assert !game.game_won?
  end

  def test_the_game_has_two_players
    game = TicTacToe.new("X OXO    ", @player1, @player2)
    assert_kind_of Player, game.player1
    assert_kind_of Player, game.player2
  end

  def test_players_have_marks_when_the_game_starts
    game = TicTacToe.new("X OXO    ", @player1, @player2)   
    game.player1.mark == TicTacToe::CROSS
    game.player2.mark == TicTacToe::NOUGHT
  end

  def test_the_game_knows_the_next_player
    game = TicTacToe.new("X OXO    ", @player1, @player2)
    assert_equal game.player1, game.next_player # X is the first because we assume X started the game    
  end

  def test_next_move_asks_player_for_move
    game = TicTacToe.new("         ", @player1, @player2)
    @player1.expects(:choose_move).returns(1)
    game.next_move!
  end

  def test_next_move_returns_board
    game = TicTacToe.new("         ", @player1, @player2)
    @player1.expects(:choose_move).returns(1)
    assert_equal " X       ", game.next_move!
  end

  def test_next_move_can_handle_nil_responses_from_players
    game = TicTacToe.new("         ", @player1, @player2)
    @player1.expects(:choose_move).returns(nil)
    game.next_move!
  end

  def test_game_over_when_won_or_all_cells_populated
    game = TicTacToe.new("XXX O O  ", @player1, @player2)
    assert_equal true, game.game_won?
    assert_equal true, game.game_over?

    game = TicTacToe.new("XOXXXOOXO", @player1, @player2)
    assert_equal true, game.game_over?
  end

  def test_game_NOT_over_until_won_or_all_cells_populated
    game = TicTacToe.new("XOXXXOOX ", @player1, @player2)
    refute game.game_won?
    refute game.game_over?
  end

  def test_next_move_does_NOT_ask_player_for_move_when_game_over
    game = TicTacToe.new("XOXXXOOXO", @player1, @player2)
    assert game.game_over?
    game.next_move! # no mocking of player choose_move method so will raise NotImplementedError if player is asked for move
    assert game.game_over?
  end

  def test_a_game_knows_who_the_winner_is
    player1 = Player.new("player1")
    player1.stubs(:choose_move).returns(6)
    player2 = Player.new("player2")
    game = TicTacToe.new("X OXO    ", player1, player2)
    game.next_move!
    assert @player1, game.winner
  end


end