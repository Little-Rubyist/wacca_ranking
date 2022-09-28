module UserSongsHelper
  def index_archive_text(song)
    achieve = @scores.find{ |x| x.user_song_id === song.id }&.achieve
    return '' if achieve.blank?
    UserScore.human_attribute_enum_value(:achieve, achieve)
  end

  def show_archive_text(score)
    UserScore.human_attribute_enum_value(:achieve, score.achieve)
  end

  def index_score(song)
    @scores.find{ |x| x.user_song_id === song.id }&.score
  end
end
