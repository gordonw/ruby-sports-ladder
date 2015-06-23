 require 'sinatra/base'
 require 'sinatra/activerecord'
 require_relative 'models/player'
 require_relative 'config/environments' #database configuration

class App < Sinatra::Application

   set :root, File.dirname(__FILE__)

   configure  do
     enable  :logging
   end

  get '/' do
    @players = Player.order(rank: :asc)
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