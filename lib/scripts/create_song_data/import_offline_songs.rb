class CreateSongData::ImportOfflineSongs
  def initialize
    before_login_url = "https://wacca.gamerch.com/%E3%82%AA%E3%83%95%E3%83%A9%E3%82%A4%E3%83%B3%E7%A8%BC%E5%83%8D%E6%99%82%E9%85%8D%E4%BF%A1%E7%B5%82%E4%BA%86%E6%A5%BD%E6%9B%B2"

    agent = Mechanize.new
    page = agent.get(before_login_url)

    tables = page.search("section#js_async_main_column_text table")
    tables.each do |table|
      elements = table.search("tbody tr")
      elements.each do |element|
        title = element.search('th a').text
        songs = Song.where(title: title)
        next if songs.blank?
        songs.update_all(can_play_offline: false)
      end
    end

    songs = [2204, 2058, 2029, 3024]
    Song.where(music_id: songs).update_all(can_play_offline: false)

    Song.where(can_play_offline: nil).update_all(can_play_offline: true)
  end
end
