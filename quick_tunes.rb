require 'digest/md5'
require 'date'

require './lib/last_fm'
require './lib/youtube'
require './models/video'
require './models/song'
require './models/artist'

class QuickTunes < Sinatra::Base

  get '/' do
    @artist = Artist.new(params[:artist])
    @artist.fetch_songs!
    if @artist.songs.any?
      cache_control :public, :must_revalidate, :max_age => 86400 # 24 hours
      last_modified Date.today
      etag Digest::MD5.hexdigest("v1::#{params[:artist].downcase.gsub(/\s/, '')}::#{Date.today}")
    end
    erb :index
  end

end
