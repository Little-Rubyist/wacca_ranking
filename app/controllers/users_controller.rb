class UsersController < ApplicationController
  def new
    redirect_to user_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserSong.insert_all(Song.all.map{|song| {user_id: User.first.id, song_id: song.id, is_favorite: false}})
      log_in @user
      redirect_to user_path, notice: 'ユーザーを登録しました'
    else
      render :new, notice: '登録に失敗しました'
    end
  end

  def show
    @q = UserSong.ransack(params[:q])
    if params[:q].nil?
      params[:q] = {}
    end
    params[:q][:user_id_eq] = current_user.id
    @scores = UserScore.select('user_scores.user_song_id as user_song_id, MAX(user_scores.score) as score, MAX(user_scores.achieve) as achieve')
                       .joins(:user_song)
                       .where(user_songs: {user_id: current_user.id})
                       .group(:user_song_id)
    songs = @q.result(distinct: true).preload(:song, :user_scores).joins(:song)
    @pagy, @songs = pagy(songs, page: params[:page], items: 25, size: [1, 2, 2, 1])
  end

  def update

  end

  def setting
  end

  def scraping
    WaccaScraping.new
  end

  def import_score_from_html
    ImportScoreFromHtml.new(params[:user][:file].path)
  end

  private

  def user_params
    params.require(:user).permit(:name,
                                 :password,
                                 :password_confirmation)
  end
end
