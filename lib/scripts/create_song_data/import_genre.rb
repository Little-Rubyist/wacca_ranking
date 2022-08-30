class CreateSongData::ImportGenre
  def initialize
    before_login_url = "https://wacca.gamerch.com/WACCA%20%E6%A5%BD%E6%9B%B2%E4%B8%80%E8%A6%A7"

    agent = Mechanize.new
    @page = agent.get(before_login_url)
    Song.genres.each do |k, v|
      import(k)
    end

    # tanoc_original to tanoc
    import_elements = @page.search("div#tanoc_original table tbody tr")
    import_elements.each do |element|
      title = element.search('th a').text
      songs = Song.where(title: title)
      next unless songs
      songs.update_all(genre: :tanoc)
    end
  end

  def import(genre)
    import_elements = @page.search("div##{genre.to_s} table tbody tr")
    import_elements.each do |element|
      p title = element.search('th a').text
      songs = Song.where(title: title)
      next unless songs
      songs.update_all(genre: genre)
    end
  end
end
