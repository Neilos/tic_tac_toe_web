require 'sinatra/base'
require 'sass'

class Game < Sinatra::Base
  
configure do
  set :root, Proc.new { File.join(File.dirname(__FILE__), "../../") }
end

get '/' do
  erb 'pages/main'.to_sym
end

get('/styles.css'){ scss :styles }

end
