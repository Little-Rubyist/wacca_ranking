class UserSongsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]
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
    @user_song = UserSong.find(params[:id])
    @song = @user_song.song
    @scores = @user_song.user_scores
  end

  def toggle_favorite
    user_song = UserSong.find(params[:id])
    if user_song.update(is_favorite: !user_song.is_favorite)
      redirect_to user_songs_path(user_song), flash: {success: '変更しました'}
    else
      render :show, flash: {danger: '更新に失敗しました'}
    end
  end
end
