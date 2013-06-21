require 'sinatra/base'

class Game < Sinatra::Base
  
configure do
  set :root, Proc.new { File.join(File.dirname(__FILE__), "../../") }
end

get '/' do
  erb 'pages/main'.to_sym
end
  
end
