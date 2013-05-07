class Song

  attr_reader :artist_name, :artist_last_fm_url, :name, :last_fm_url, :last_fm_rank, :video

  def initialize(info={}, video=nil)
    @artist_name = info[:artist_name]
    @artist_last_fm_url = info[:artist_last_fm_url]
    @name = info[:name]
    @last_fm_url = info[:last_fm_url]
    @last_fm_rank = info[:last_fm_rank]
    @video = video
  end

  def fetch_video!
    @video = Video.new("#{artist_name} - #{name}")
    @video.fetch!
    true
  end

  def self.from_artist(artist, limit=5)
    LastFm::Track.search(artist.name, limit).map do |track|
      song = self.new(
        artist_name: track.artist_name,
        artist_last_fm_url: track.artist_url,
        name: track.name,
        last_fm_url: track.url,
        last_fm_rank: track.rank
      )
      song.fetch_video!
      song
    end
  end

end
