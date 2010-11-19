# You'll need to require these if you
# want to develop while running with ruby.
# The config/rackup.ru requires these as well
# for it's own reasons.
#
# $ ruby heroku-sinatra-app.rb
#
require 'cgi'
require 'open-uri'

require 'rubygems'
require 'sinatra'
require 'crack/xml'

LASTFM_API_KEY = "2eda7af022a1e005cb1d8f3b7583b612"

configure :production do
  # Configure stuff here you'll want to
  # only be run at Heroku at boot

  # TIP:  You can get you database information
  #       from ENV['DATABASE_URL'] (see /env route below)
end

get '/' do
  @artist = params[:artist].to_s.downcase
  unless @artist == ''
    hash = top_tracks_hash(top_tracks_xml(@artist))
    @tracks = top_tracks(hash, 5)
  end
  erb :index
end

# Test at quicktunes.heroku.com
# You can see all your app specific information this way.
# IMPORTANT! This is a very bad thing to do for a production
# application with sensitive information
#get '/env' do
#  ENV.inspect
#end

def escape(text)
  CGI::escape(text.to_s.downcase)
end

def top_tracks_xml(artist)
  url = "http://ws.audioscrobbler.com/2.0/?method=artist.gettoptracks&artist=#{escape(artist)}&api_key=#{LASTFM_API_KEY}"
  open(url)
end

def top_tracks_hash(xml)
  Crack::XML.parse(xml)
end

def top_tracks(hash, count=5)
  tracks = hash['lfm']['toptracks']['track'][0..count-1]
  tracks.map do |track|
    "#{track['artist']['name']} - #{track['name']}"
  end
end
