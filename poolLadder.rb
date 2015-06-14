require 'sinatra'
require 'tilt/erb'

set :root, File.dirname(__FILE__)

get '/' do
  @players = fetch_player_rankings
  erb :index
end

def fetch_player_rankings
  []
end

post '/' do
  @players = fetch_player_rankings
  playerName = params[:playerName]
  if playerName != nil
    @players = [playerName]
  end
  erb :index
end

