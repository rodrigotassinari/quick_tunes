class Song

  attr_reader :artist, :title, :video

  def initialize(artist, title, video=nil)
    @artist = artist
    @title = title
    @video = video
  end

  def fetch_video!
    @video = Video.new(artist, title)
    @video.fetch!
    true
  end

  def self.from_artist(name, limit=5)
    LastFm::Track.search(self.name, limit).map do |track|
      song = self.new(track.artist, track.title)
      song.fetch_video!
      song
    end
  end

end
