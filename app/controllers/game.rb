require 'sinatra/base'
require 'sass'
require 'json'
require_relative '../models/tic_tac_toe'
require_relative '../models/human_player'
require_relative '../models/computer_player'

class Game < Sinatra::Base

configure do
  set :root, Proc.new { File.join(File.dirname(__FILE__), "../../") }
  set :erb, layout => :"layouts/main_layout.erb"
end

before do
  @player1 = HumanPlayer.new("Dave")
  @player2 = HumanPlayer.new("Jeff")
end

def generate_game_instructions(game)
  if game.game_won? && game.valid?
    "Game over. The winner is #{game.winner}!"
  elsif game.game_won?
    "Game over. Play again?"
  elsif game.game_over?
    "Game over. It's a draw!"
  elsif game.to_s == "         "
    "New Game! #{game.next_player}'s turn first (#{game.next_player} is '#{game.next_player.mark}'s)"
  else
    "#{game.next_player}'s turn (#{game.next_player} is '#{game.next_player.mark}'s)"
  end
end

def state_of(game)
  game.game_over? ? "game_over" : "in_progress}"
end

get('/styles.css'){ scss :'stylesheets/styles' }

get '/' do
  @game = TicTacToe.new("         ", @player1, @player2)
  @squares = @game.board
  @game_instructions = generate_game_instructions(@game)
  erb 'pages/main'.to_sym
end

post '/nextmove' do
  game = TicTacToe.new(params[:board], @player1, @player2)
  game.next_move! unless game.game_over?
  { :board => game.to_s, 
    :game_instructions => generate_game_instructions(game),
    :game_state => state_of(game), 
    :next_player_mark => game.next_player.mark }.to_json
end

end
