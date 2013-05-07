require 'cgi'
require 'open-uri'
require 'rexml/document'

module LastFm

  class Search
    LASTFM_API_KEY = ENV['LASTFM_API_KEY']

    def initialize(query)
      @query = query.to_s.downcase
    end

    def top_tracks(limit=5, use_cache=true)
      fetch(use_cache) && parse
      @info['lfm']['toptracks']['track'][0..limit-1]
    end

    private

    def fetch(use_cache=false)
      @xml = open("http://ws.audioscrobbler.com/2.0/?api_key=#{LASTFM_API_KEY}&method=artist.gettoptracks&artist=#{CGI::escape(@query)}")
      true
    end

    def parse
      return unless @xml
      @info = Crack::XML.parse(@xml)
      true
    end

  end

  class Track
    attr_reader :title, :artist

    def initialize(track_info)
      @artist = track_info['artist']['name']
      @title = track_info['name']
    end

    def full_title
      [artist, title].
        reject { |v| v.nil? || v.to_s.strip == '' }.
        join(' - ')
    end

    def self.search(query, limit=5)
      track_info = LastFm::Search.new(query).top_tracks(limit)
      track_info.map { |info| self.new(info) }
    end
  end

end
