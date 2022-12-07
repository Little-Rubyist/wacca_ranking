class UserScoresController < ApplicationController
  def new
    @user_song = UserSong.find(params[:user_song_id])
    @song = @user_song.song
    @user_score = UserScore.new
    @user_score.user_song = @user_song
  end

  def create
    @user_song = UserSong.find(user_score_params[:user_song_id])
    @song = @user_song.song
    @user_score = UserScore.create(user_score_params)
    @user_score.user_song = @user_song
    if @user_score.save
      redirect_to user_song_path(user_score_params[:user_song_id]), flash: {success: 'スコアを追加しました'}
    else
      flash.now[:danger] = 'スコアの追加に失敗しました'
      render :new
    end
  end

  def destroy
    user_score = UserScore.find(params[:id])
    user_song = user_score.user_song
    if user_score.destroy
      flash[:success] = 'スコアを削除しました'
    else
      flash[:danger] = 'スコアの削除に失敗しました'
    end
    redirect_to user_song_path(user_song)
  end

    private

    def user_score_params
      params.require(:user_score).permit(:user_song_id,
                                         :score,
                                         :played_on,
                                         :achieve)
    end
end
