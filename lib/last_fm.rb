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
    attr_reader :name, :url, :rank, :artist_name, :artist_url

    # > track_info = tracks[0]
    # => {
    #           "name" => "Beija Eu",
    #       "duration" => "196",
    #      "playcount" => "12360",
    #      "listeners" => "4367",
    #           "mbid" => "4a43d1f4-d4a9-4ae1-8e76-80c4c163ebfa",
    #            "url" => "http://www.last.fm/music/Marisa+Monte/_/Beija+Eu",
    #     "streamable" => "0",
    #         "artist" => {
    #         "name" => "Marisa Monte",
    #         "mbid" => "f81f19b9-c76e-43ac-8656-bb56071785fb",
    #          "url" => "http://www.last.fm/music/Marisa+Monte"
    #     },
    #          "image" => [
    #         [0] "http://userserve-ak.last.fm/serve/34s/85443437.png",
    #         [1] "http://userserve-ak.last.fm/serve/64s/85443437.png",
    #         [2] "http://userserve-ak.last.fm/serve/126/85443437.png",
    #         [3] "http://userserve-ak.last.fm/serve/300x300/85443437.png"
    #     ],
    #           "rank" => "1"
    # }
    def initialize(track_info)
      @name = track_info['name']
      @url = track_info['url']
      @rank = track_info['rank']
      @artist_name = track_info['artist']['name']
      @artist_url = track_info['artist']['url']
    end

    def full_name
      [@artist_name, @name].
        reject { |v| v.nil? || v.to_s.strip == '' }.
        join(' - ')
    end

    def self.search(query, limit=5)
      LastFm::Search.
        new(query).
        top_tracks(limit).
        map { |info| self.new(info) }
    end
  end

end
