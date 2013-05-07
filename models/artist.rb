require 'cgi'
class Artist

  attr_reader :name, :songs

  def initialize(name)
    @name = name
    @songs = []
  end

  def fetch_songs!
    return if no_name?
    @songs = Song.from_artist(self, 5)
    update_artist_info!
    true
  end

  def no_name?
    @name.nil? || @name.to_s.strip == ''
  end

  def last_fm_url
    return if no_name?
    @last_fm_url || "http://www.last.fm/music/#{CGI::escape(@name)}"
  end

  private

    def update_artist_info!
      return if @songs.empty?
      song = @songs.first
      @name = song.artist_name
      @last_fm_url = song.artist_last_fm_url
      true
    end

end
