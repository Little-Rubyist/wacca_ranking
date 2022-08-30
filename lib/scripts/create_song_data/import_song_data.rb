class CreateSongData::ImportSongData
  def initialize


    html = File.read('tmp/wacca_mypage.htm')
    page = Nokogiri::HTML.parse(html, nil)

    list = page.css('.playdata__score-list__wrap.grid.muuri').css('li.item')
    list.each do |song|
      music_id = song.at_css('form').attribute('name').text.match(/detail([0-9]*)/)[1]
      title = song.at('.playdata__score-list__song-info__name').text
      ruby = song.attribute('data-music_name_ruby').text
      normal_level = song.attribute('data-rank_normal_level').text
      hard_level = song.attribute('data-rank_hard_level').text
      expert_level = song.attribute('data-rank_expert_level').text
      inferno_level = song.attribute('data-rank_inferno_level').text
      Song.create(song_id: music_id,
                  title: title,
                  ruby: ruby,
                  diff_type: :normal,
                  difficulty: calculate_level(normal_level))
      Song.create(song_id: music_id,
                  title: title,
                  ruby: ruby,
                  diff_type: :hard,
                  difficulty: calculate_level(hard_level))
      Song.create(song_id: music_id,
                  title: title,
                  ruby: ruby,
                  diff_type: :expert,
                  difficulty: calculate_level(expert_level))
      unless calculate_level(inferno_level) == '0'
        Song.create(song_id: music_id,
                    title: title,
                    ruby: ruby,
                    diff_type: :inferno,
                    difficulty: calculate_level(inferno_level))
      end
    end
  end

  def calculate_level(level)
    if level.match?(/[0-9]+.[1-9]/)
      return "#{level.to_i}.5"
    end
    level
  end
end
