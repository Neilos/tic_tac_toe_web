require 'sinatra/base'

class Game < Sinatra::Base
  
  get "/" do
    "hello"
  end
  
end