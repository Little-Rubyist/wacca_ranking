class UserSongsController < ApplicationController
  def index
    if params[:q].nil?
      params[:q] = {}
      params[:q][:song_difficulty_gteq] = 1
    end

    @q = UserSong.where(user_id: current_user.id).ransack(params[:q])
    @scores = UserScore.select('user_scores.user_song_id as user_song_id, MAX(user_scores.score) as score, MAX(user_scores.achieve) as achieve')
                       .joins(:user_song)
                       .where(user_songs: {user_id: current_user.id})
                       .group(:user_song_id)
    songs = @q.result(distinct: true).preload(:song, :user_scores).joins(:song)
    @pagy, @songs = pagy(songs, page: params[:page], items: 25, size: [1, 2, 2, 1])
  end

  def show

  end
end
