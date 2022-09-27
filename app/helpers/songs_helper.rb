module SongsHelper
  def show_archive_text(song)
    achieve = @scores.find{ |x| x.user_song_id === song.id }&.achieve
    Song.human_attribute_enum_value(:achieve, achieve)
  end

  def show_score(song)
    @scores.find{ |x| x.user_song_id === song.id }&.score
  end
end
