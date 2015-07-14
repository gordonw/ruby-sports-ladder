require 'sinatra/base'
require 'sinatra/assetpack'
require 'sinatra/activerecord'
require_relative 'models/player'
require_relative 'models/ladder'
require_relative 'config/environments'

class App < Sinatra::Base

  set :root, File.dirname(__FILE__)

  register Sinatra::AssetPack
  assets do
    # serve '/js', from: 'js'
    serve '/bower_components', from: 'bower_components'

    js :modernizr, [
                     '/bower_components/modernizr/modernizr.js',
                 ]

    js :libs, [
                '/bower_components/jquery/dist/jquery.js',
                '/bower_components/foundation/js/foundation.js'
            ]

    js :application, [
                       '/js/app.js'
                   ]

    js_compression :jsmin
  end

  configure do
    enable :logging
  end


  get '/' do
    @players = Player.order(position: :asc)
    erb :index, :locals => { :ladders => (Ladder.order(name: :asc)) }
  end


  post '/' do
    ladder = Ladder.new(params[:ladder]).tap { |ladder|
       ladder.slug = create_slug
    }
    unless ladder.name.empty?
      unless ladder.save
        "Ladder did not save for some reason"
      end
    end
    redirect "/"
  end


  get '/ladder/:ladder_slug' do |slug|
    erb :show_ladder, :locals => { :ladder => (Ladder.find_by slug: slug) }
  end


  post '/ladder/:ladder_slug' do |slug|

    player = Player.new(params[:player]).tap { |player|
      player.ladder_id = Ladder.find_by(slug: slug).id
    }


    unless player.name.empty?
      unless player.save
        "Player did not save for some reason"
      end
    end
    redirect "/ladder/#{slug}"
  end

  def create_slug
    require 'securerandom'
    (SecureRandom.urlsafe_base64 7).upcase
  end

end