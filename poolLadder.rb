require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' #database configuration
require 'tilt/erb'
require './models/player'

set :root, File.dirname(__FILE__)

get '/' do
  @players = Player.all
  erb :index
end

post '/' do
  player = Player.new(params[:player])

  unless player.name.empty?
    unless player.save
      "Player did not save for some reason"
    end
  end
  redirect '/'
end

