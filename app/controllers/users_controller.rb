class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :update, :setting, :import_score_from_html, :import_score_from_csv]
  def new
    redirect_to user_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserSong.insert_all(Song.all.map{|song| {user_id: @user.id, song_id: song.id, is_favorite: false}})
      log_in @user
      redirect_to user_path, flash: { success: 'ユーザーを登録しました' }
    else
      flash.now[:danger] = '更新に失敗しました'
      render :new
    end
  end

  def show
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

  def update
    if current_user.update(user_params)
      redirect_to settings_user_path, flash: { success: 'ユーザー情報を更新しました' }
    else
      flash.now[:danger] = '更新に失敗しました'
      render :setting
    end
  end

  def setting
  end

  def scraping
    WaccaScraping.new
  end

  def how_to_import
  end

  def import_score_from_html
    ImportScoreFromHtml.new(current_user, params[:user][:file].path)
    redirect_to user_path, flash: { success: 'インポートが終了しました' }
  end

  def import_score_from_csv
    ImportScoreFromCsv.new(current_user, params[:user][:file].path)
    redirect_to user_path, flash: { success: 'インポートが終了しました' }
  end

  private

  def user_params
    params.require(:user).permit(:name,
                                 :display_name,
                                 :password,
                                 :password_confirmation,
                                 :current_password)
  end
end
