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
  use(Rack::Session::Pool,
    :key => 'rack.session',
    :path => '/',
    :session_secret => 'this is very secret I hate playing tic tac toe')
end

before do
  @player1 = HumanPlayer.new("Dave")
  @player2 = HumanPlayer.new("Jeff")
end

def game_instructions(game)
  if game.game_won? && game.valid?
    "Game over. The winner is #{game.winner.to_s}!"
  elsif game.game_won?
    "Game over. Play again?"
  elsif game.game_over?
    "Game over. It's a draw!"
  elsif game.to_s == "         "
    "New Game! #{game.next_player.to_s}'s turn first ('#{game.next_player.mark}'s)"
  else
    "#{game.next_player.to_s}'s turn ('#{game.next_player.mark}'s)"
  end
end

def state_of(game)
  game.game_over? ? "game_over" : "in_progress"
end

get('/styles.css'){ scss :'stylesheets/styles' }



get '/' do
  @player1_name = params[:player1_name] == "" ? "player 1" : params[:player1_name]
  @player2_name = params[:player2_name] =="" ? "player 2" : params[:player2_name]
  
  session[@player1_name] = {:won => 0, :lost=> 0, :drawn => 0}
  session[@player2_name] = {:won => 0, :lost=> 0, :drawn => 0}
  
  @player1_won = (session[@player1_name] && session[@player1_name][:won]) || 0
  @player1_lost = (session[@player1_name] && session[@player1_name][:lost]) || 0
  @player1_drawn = (session[@player1_name] && session[@player1_name][:drawn]) || 0

  @player2_won = (session[@player2_name] && session[@player2_name][:won]) || 0
  @player2_lost = (session[@player2_name] && session[@player2_name][:lost]) || 0
  @player2_drawn = (session[@player2_name] && session[@player2_name][:drawn]) || 0
  
  player1 = @player1_name=="computer" ? ComputerPlayer.new(@player1_name) : HumanPlayer.new(@player1_name)
  player2 = @player2_name=="computer" ? ComputerPlayer.new(@player2_name) : HumanPlayer.new(@player2_name)
  game = TicTacToe.new("         ", player1, player2)
  @squares = game.board
  @game_instructions = game_instructions(game)

  erb 'pages/main'.to_sym
end


post '/nextmove' do
  player1_name = params[:player1_name]=="" ? "player 1" : params[:player1_name]
  player2_name = params[:player2_name]=="" ? "player 2" : params[:player2_name]

  session[player1_name] = {} unless session[player1_name]
  session[player2_name] = {} unless session[player2_name]

  player1 = player1_name=="computer" ? ComputerPlayer.new(player1_name) : HumanPlayer.new(player1_name)
  player2 = player2_name=="computer" ? ComputerPlayer.new(player2_name) : HumanPlayer.new(player2_name)

  game = TicTacToe.new(params[:board], player1, player2)
  game.next_move! unless game.game_over?

  # if game.game_won?
  #   session[game.winner.to_s][:won] += 1 if session[game.winner.to_s]
  #   session[game.loser.to_s][:lost] += 1 if session[game.loser.to_s]
  # elsif game.game_over?
  #   session[player1_name][:drawn] += 1 if session[player1_name]
  #   session[player2_name][:drawn] += 1 if session[player2_name]
  # end

  { :board => game.to_s, 
    :game_instructions => game_instructions(game),
    :game_state => state_of(game), 
    :next_player_mark => game.next_player.mark,
    :player1_name => player1_name,
    :player1_won => (session[player1_name] && session[player1_name][:won]) || 0,
    :player1_lost => (session[player1_name] && session[player1_name][:lost]) || 0,
    :player1_drawn => (session[player1_name] && session[player1_name][:drawn]) || 0,
    :player2_name => player2_name,
    :player2_won => (session[player2_name] && session[player2_name][:won]) || 0,
    :player2_lost => (session[player2_name] && session[player2_name][:lost]) || 0,
    :player2_drawn => (session[player2_name] && session[player2_name][:drawn]) || 0
  }.to_json
end

end
