require 'cgi'
class Video

  def initialize(artist, title)
    @artist = artist
    @title = title
    @youtube_id = 'foobar'
  end

  def fetch!
    # TODO youtube search
  end

  def search_query
    CGI::escape("#{@artist} - #{@title}")
  end

  def embed_html
    <<-EOF
      <object width="425" height="350">
        <param name="movie" value="http://www.youtube.com/v/#{@youtube_id}&feature=youtube_gdata_player"></param>
        <param name="wmode" value="transparent"></param>
        <embed src="http://www.youtube.com/v/#{@youtube_id}&feature=youtube_gdata_player" type="application/x-shockwave-flash" wmode="transparent" width="425" height="350"></embed>
      </object>
    EOF
  end

  def search_more_url
    "http://www.youtube.com/results?aq=f&search_query=#{search_query}"
  end

end
