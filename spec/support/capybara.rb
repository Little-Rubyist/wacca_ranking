require 'capybara/rspec'
require 'selenium-webdriver'

# Custom Driver
Capybara.register_driver :remote_chrome do |app|
  url = ENV["SELENIUM_DRIVER_URL"]
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('no-sandbox')
  options.add_argument('headless')
  options.add_argument('disable-gpu')
  options.add_argument('disable-dev-shm-usage')
  options.add_argument('remote-debugging-port=9222')
  options.add_argument('window-size=950, 800')

  Capybara::Selenium::Driver.new(app,
                                 browser: :remote,
                                 url: url,
                                 capabilities: options)
end

# Setting for System Spec
RSpec.configure do |config|
  config.before(:each, type: :system) do |example|
    if example.metadata[:use_js]
      options = {}
      if ENV.key?('SELENIUM_DRIVER_URL')
        Capybara.server_host = ENV['CAPYBARA_SERVER_HOST']
        Capybara.app_host = ENV['CAPYBARA_APP_HOST']

        Capybara.register_driver :remote_chrome do |app|
          url = ENV['SELENIUM_DRIVER_URL']

          options = Selenium::WebDriver::Chrome::Options.new
          options.add_argument('no-sandbox')
          options.add_argument('headless')
          options.add_argument('disable-gpu')
          options.add_argument('window-size=1280,800')

          Capybara::Selenium::Driver.new(app, browser: :remote, url: url, capabilities: options)
        end

        driven_by :remote_chrome
      else
        driven_by :selenium, using: :headless_chrome, screen_size: [1280, 800] do |opt|
          opt.add_argument('--headless --disable-gpu --no-sandbox --lang=ja-JP')
        end
      end
    else
      driven_by :rack_test
    end
  end
end