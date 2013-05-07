require 'cgi'
class Artist

  attr_reader :name, :songs

  def initialize(name)
    @name = name
    @songs = []
  end

  def fetch_songs!
    return if no_name?
    @songs = Song.from_artist(name, 5)
  end

  def no_name?
    name.nil? || name.to_s.strip == ''
  end

  def last_fm_page
    return if no_name?
    "http://www.last.fm/music/#{CGI::escape(name)}"
  end

end
