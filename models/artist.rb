class Artist

  attr_reader :name, :songs

  def initialize(name)
    @name = name
    @songs = []
  end

  def fetch_songs!
    return if self.name.nil? || self.name.to_s.strip == ''
    @songs = Song.from_artist(self.name, 5)
  end

end
