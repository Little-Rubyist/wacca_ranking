class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if (user = User.create(user_params))
      log_in user
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
