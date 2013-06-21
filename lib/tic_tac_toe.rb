require_relative 'player'
require_relative 'line_aware'

class TicTacToe
  include LineAware
  attr_reader :board, :player1, :player2
  CROSS = "X"
  NOUGHT = "0"
  SPACE = " "
  LINE = "\n----------------------------\n"
  BOARD_HORIZONTAL = "\n-----------\n"
  BOARD_VERTICAL = "|"

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
    board[get_move_from next_player] = next_player.mark 
  end

  def to_s
    board.join
  end

  def game_table
    string = "\n\n" + (0..8).map { |i| "#{ BOARD_HORIZONTAL if i % 3 ==0 && i != 0 }" + "#{ BOARD_VERTICAL if (i % 3 == 1) || (i % 3 == 2) }" + "#{ SPACE + board[i] + SPACE }" }.join + "\n"
  end

  def play!
    print "NEW GAME!"
    until game_over?
      print game_table + LINE + "#{next_player}'s turn. "
      next_move!
    end
    print game_table + (game_won? ? "\n\nGAMES OVER.\nTHE WINNER IS #{winner}!" + LINE : "\n\nGAMES OVER.\nIT'S A DRAW!" + LINE)
    board
  end


private

  def get_move_from(player)
    begin
      move = player.choose_move(board)
      return move if legal? move
      print "#{move} is invalid! Choose an empty postion (0,1,2,3,4,5,6,7,8): "
    end until legal?(move)
  end

  def legal?(move)
    board[move] == SPACE && [0,1,2,3,4,5,6,7,8].include?(move)
  end

  def difference_between(number_of)
    (number_of[:this] - number_of[:that]).abs
  end

  def count(things)
    things[:within].count(things[:of])
  end
end
