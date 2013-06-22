require 'sinatra/base'
require 'sass'
require_relative '../models/tic_tac_toe'
require_relative '../models/human_player'
require_relative '../models/computer_player'

class Game < Sinatra::Base
  
configure do
  set :root, Proc.new { File.join(File.dirname(__FILE__), "../../") }
end

before do
  @player1 = HumanPlayer.new("Dave")
  @player2 = HumanPlayer.new("Jeff")
end

get('/styles.css'){ scss :'stylesheets/styles' }

get '/' do
  @game = TicTacToe.new("X O X    ", @player1, @player2)
  @squares = @game.board
  erb 'pages/main'.to_sym
end

post '/nextmove' do
  @game = TicTacToe.new(params['board'], @player1, @player2)
  @game.next_move!
  @game.board
  "X  O  X  "
end

end
