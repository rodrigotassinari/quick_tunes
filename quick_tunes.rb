require 'rubygems'
require 'bundler'
Bundler.require

require './lib/last_fm'
require './lib/youtube'
require './models/video'
require './models/song'
require './models/artist'

class QuickTunes < Sinatra::Base

  get '/' do
    @artist = Artist.new(params[:q])
    @artist.fetch_songs!
    erb :index
  end

end
