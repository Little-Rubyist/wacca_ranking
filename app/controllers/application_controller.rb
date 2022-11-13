class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pagy::Backend
  add_flash_types :success, :info, :warning, :danger
  before_action :set_locale

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end
  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        redirect_to sign_in_url
      end
    end
end
