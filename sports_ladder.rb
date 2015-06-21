 require 'sinatra/base'
 require 'sinatra/activerecord'
 require './models/player'
 require './config/environments' #database configuration

class SportsLadder < Sinatra::Application

   set :root, File.dirname(__FILE__)

   configure  do
     enable  :logging
   end

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

end