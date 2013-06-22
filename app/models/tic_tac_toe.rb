require_relative 'player'
require_relative 'line_aware'

class TicTacToe
  include LineAware
  attr_reader :board, :player1, :player2
  CROSS = "X"
  NOUGHT = "O"
  SPACE = " "

  def initialize(board_string, cross_player, nought_player)
    raise RuntimeError unless board_string.size == 9
    @board = board_string.split('')
    
    @player1 = cross_player
    @player1.mark = CROSS

    @player2 = nought_player
    @player2.mark = NOUGHT
  end

  def valid?
    1 >= difference_between(:this => (count of: CROSS, within: board), 
                            :that => (count of: NOUGHT, within: board))
  end

  def game_won?
    lines(board).any?{|line| line.uniq.count==1 and line.first!= SPACE }
  end

  def game_over?
    game_won? || board.count(SPACE) == 0
  end

  def winner
    next_player==player1 ? player2 : player1
  end

  def next_player
    (count of: CROSS, within: board) > (count of: NOUGHT, within: board) ? player2 : player1
  end

  def next_move!
    move = get_move_from next_player unless game_over?
    board[move] = next_player.mark if move
    to_s
  end

  def to_s
    board.join
  end


private

  def get_move_from(player)
      move = player.choose_move(board)
  end

  def difference_between(number_of)
    (number_of[:this] - number_of[:that]).abs
  end

  def count(things)
    things[:within].count(things[:of])
  end
end
