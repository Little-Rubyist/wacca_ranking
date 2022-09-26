class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pagy::Backend

  private
  # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        redirect_to sign_in_url
      end
    end
end
