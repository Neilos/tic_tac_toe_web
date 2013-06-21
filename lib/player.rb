require_relative 'line_aware'
require_relative 'tic_tac_toe'

class Player
  include LineAware
  attr_accessor :mark

  def initialize(name)
    @name = name
    @mark = TicTacToe::CROSS
  end

  def choose_move(board)
    raise NotImplementedError, "implement this method in any subclasses"
  end

  def to_s
    @name
  end

end