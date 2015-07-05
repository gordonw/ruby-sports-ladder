require 'sinatra/base'
require 'sinatra/activerecord'
require_relative 'models/player'
require_relative 'models/ladder'
require_relative 'config/environments'

class App < Sinatra::Application

  set :root, File.dirname(__FILE__)

  configure do
    enable :logging
  end

  get '/' do
    @players = Player.order(position: :asc)
    erb :index, :locals => { :ladders => (Ladder.order(name: :asc)) }
  end

  get '/ladder/:ladder_slug' do |slug|
    erb :show_ladder, :locals => {
                        :ladder => (Ladder.find_by slug: slug),
                        :players => (Player.ordered_by_position_asc)
                    }
  end

  post '/ladder/:ladder_slug' do |slug|

    player = Player.new(params[:player])
    player.ladder_id = Ladder.find_by( slug: slug).id

    unless player.name.empty?
      unless player.save
        "Player did not save for some reason"
      end
    end
    redirect "/ladder/#{slug}"
  end

end