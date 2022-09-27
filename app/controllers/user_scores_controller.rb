class UserScoresController < ApplicationController
  def new
    @user_song = UserSong.find(params[:user_song_id])
    @song = @user_song.song
    @user_score = UserScore.new
    @user_score.user_song = @user_song
  end

  def create
    if UserScore.create(user_score_params)
      redirect_to user_song_path(user_score_params[:user_song_id]), flash: {success: 'スコアを追加しました'}
    else
      flash.now[:danger] = 'スコアの追加に失敗しました'
      render :new
    end
  end

    private

    def user_score_params
      params.require(:user_score).permit(:user_song_id,
                                         :score,
                                         :achieve)
    end
end
