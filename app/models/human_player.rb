require_relative 'player'

class HumanPlayer < Player
  def choose_move(board)
    print "#{self}, you are playing #{self.mark}'s.\nEnter move (0,1,2,3,4,5,6,7,8): "
    gets.to_i
  end
end
