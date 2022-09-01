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

    # update genre that cannot import gamerch
    update_cannot_import_songs
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

  def update_cannot_import_songs
    songs = [
      { music_id: 2007,
        genre: :touhou},
      { music_id: 1051,
        genre: :variety},
      { music_id: 3057,
        genre: :original},
      { music_id: 1265,
        genre: :touhou},
      { music_id: 2049,
        genre: :tanoc},
      { music_id: 2047,
        genre: :tanoc},
      { music_id: 1087,
        genre: :tanoc},
      { music_id: 1212,
        genre: :original},
      { music_id: 3024,
        genre: :vocaloid},
      { music_id: 3041,
        genre: :variety},
      { music_id: 1086,
        genre: :tanoc},
      { music_id: 3075,
        genre: :tanoc},
      { music_id: 2204,
        genre: :anime_pop},
      { music_id: 1241,
        genre: :variety},
      { music_id: 2058,
        genre: :anime_pop},
      { music_id: 1071,
        genre: :tanoc},
      { music_id: 2029,
        genre: :anime_pop}
    ]
    songs.each do |song|
      Song.where(music_id: song[:music_id]).update_all(genre: song[:genre])
    end
  end
end
