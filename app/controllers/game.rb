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
  @game = TicTacToe.new("X O X    ", @player1, @player2)
  @squares = @game.board
end

get('/styles.css'){ scss :'stylesheets/styles' }

get '/' do
  erb 'pages/main'.to_sym
end

get '/nextmove' do
  @game.next_move!
  erb 'pages/main'.to_sym
end

end
