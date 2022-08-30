class WaccaScraping
  def initialize
    before_login_url = "https://tgk-aime-gw.sega.jp/common_auth/login?redirect_url=https%3A%2F%2Fwacca.marv-games.jp%2Fweb%2Flogin%2Fselect&site_id=WACCA&back_url=https%3A%2F%2Fwacca.marv-games.jp%2Fweb%2Flogin&shf=0&alof=0" # 無線ルータのログイン画面で試した
    target_pattern = 'https://wacca.marv-games.jp/web/top'

    uri = URI.parse(before_login_url)

    options = Selenium::WebDriver::Remote::Capabilities.chrome(
      accept_insecure_certs: true
    )
    # options.add_argument('--no-sandbox')
    # options.add_argument('--disable-dev-shm-usage')
    driver = Selenium::WebDriver.for :remote, url: ENV.fetch("SELENIUM_DRIVER_URL"), capabilities: options
    driver.get uri
    p driver.title
    driver.manage.timeouts.implicit_wait = 30

    driver.quit

    # visible_browser = Ferrum::Browser.new headless: false, browser_name: :firefox
    # visible_browser.go_to before_login_url
    # begin
    #   sleep 1 # 適当に待つ
    # end until target_pattern =~ visible_browser.current_url
    #
    # browser = Ferrum::Browser.new
    # visible_browser.cookies.all.each_value do |cookie|
    #   p cookie
    #   # browser.cookies.set(cookie) # unreleased (ferrum 0.11 does not supported)
    #   browser.cookies.set(**cookie.instance_variable_get(:@attributes).transform_keys(&:to_sym))
    # end
    # current_url = visible_browser.current_url
    # visible_browser.quit
    # visible_browser = nil
    # browser.go_to current_url
    #
    # browser.screenshot(path: "screenshot.jpg")
    # browser.quit
  end
end
