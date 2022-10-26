class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pagy::Backend
  add_flash_types :success, :info, :warning, :danger
  before_action :set_locale

  def set_locale
    I18n.locale = locale
  end

  def locale
    @locale ||= (params[:locale] || I18n.default_locale)
  end

  private
  # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        redirect_to sign_in_url
      end
    end
end
