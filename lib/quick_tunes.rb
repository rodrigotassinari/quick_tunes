require 'rubygems'
require 'cgi'
require 'crack/xml'
require 'open-uri'

module QuickTunes
  
  class Artist
    attr_reader :name, :api_key
    
    def initialize(name, api_key)
      @name = name
      @api_key = api_key
    end
    
    def top_tracks(count=5)
      tracks = self.top_tracks_hash['lfm']['toptracks']['track'][0..count-1]
      tracks.map do |track|
        "#{track['artist']['name']} - #{track['name']}"
      end
    end
    
    def top_videos(count=5)
      tracks = self.top_tracks(count)
      tracks.map do |track|
        "#{track}: http://www.youtube.com/results?search_query=#{CGI::escape(track.downcase)}&aq=f"
      end
    end
    
    protected
    
      def escaped_name
        CGI::escape(self.name.downcase)
      end
    
      def top_tracks_xml
        url = "http://ws.audioscrobbler.com/2.0/?method=artist.gettoptracks&artist=#{self.escaped_name}&api_key=#{self.api_key}"
        open(url)
      end
      
      def top_tracks_hash
        Crack::XML.parse(self.top_tracks_xml)
      end
      
  end
  
end
