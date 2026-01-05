module SessionSpecHelper
  def log_in_as(user)
    visit sign_in_path
    fill_in 'session_name', with: user.name
    fill_in 'session_password', with: 'password123'
    click_button 'ログイン'
  end
end

RSpec.configure do |config|
  config.include SessionSpecHelper, type: :system
end