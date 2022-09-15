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
  end

  def scraping
    WaccaScraping.new
  end

  private

  def user_params
    params.require(:user).permit(:name,
                                 :password,
                                 :password_confirmation)
  end
end
