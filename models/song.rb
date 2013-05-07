class Song

  attr_reader :artist, :title, :video

  def initialize(artist, title, video=nil)
    @artist = artist
    @title = title
    @video = video
  end

  def self.from_artist(name, limit=5)
    LastFm::Track.search(self.name, 5).map do |track|
      video = nil # TODO youtube search
      self.new(track.artist, track.title, video)
    end
  end

end
