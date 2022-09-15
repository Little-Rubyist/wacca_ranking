class ImportScoreFromHtml
  def initialize
    html = File.read('tmp/wacca_mypage.htm')
    page = Nokogiri::HTML.parse(html, nil)
    list = page.css('.playdata__score-list__wrap.grid.muuri').css('li.item')
    @user = User.first

    favorite_songs = page.css('.playdata__score-list__wrap.grid.muuri')
                         .search('li.filter-favorite').map do |song|
      song.at_css('form').attribute('name').text.match(/detail([0-9]*)/)[1]
    end
    @user.user_songs.joins(:song).where(songs: {music_id: favorite_songs}).update_all(is_favorite: true)

    list.each do |song|
      music_id = song.at_css('form').attribute('name').text.match(/detail([0-9]*)/)[1]
      normal_score = song.attribute('data-rank_normal_score').text
      hard_score = song.attribute('data-rank_hard_score').text
      expert_score = song.attribute('data-rank_expert_score').text
      inferno_score = song.attribute('data-rank_inferno_score').text
      normal_achieve = find_achieve_src(song, 'normal')
      hard_achieve = find_achieve_src(song, 'hard')
      expert_achieve = find_achieve_src(song, 'expert')
      inferno_achieve = find_achieve_src(song, 'inferno')
      songs = @user.user_songs.joins(:song).where(songs: {music_id: music_id})
      songs.each do |song_data|
        diff = song_data.song.diff_type
        next if eval("#{diff}_score") === "0"
        song_data.user_scores.create(score: eval("#{diff}_score"),
                                      achieve: check_achieve(eval("#{diff}_achieve")))
      end
    end
  end

  def find_achieve_src(song, different)
    song.at(".score__icon__#{different}").css('[alt="achieveimage"]').attribute('src').text
  end

  def calculate_rate(score)
    if score == 1000000
      'Master'
    elsif 990000 <= score <= 999999
      return 'SSS+'
    elsif 980000 <= score <= 989999
      return 'SSS'
    elsif 970000 <= score <= 979999
      return 'SS+'
    elsif 950000 <= score <= 969999
      return 'SS'
    elsif 930000 <= score <= 949999
      return 'S+'
    elsif 900000 <= score <= 929999
      return 'S'
    elsif 850000 <= score <= 899999
      return 'AAA'
    elsif 800000 <= score <= 849999
      return 'AA'
    elsif 700000 <= score <= 799999
      return 'A'
    elsif 300000 <= score <= 699999
      return 'B'
    elsif 1 <= score <= 299999
      return 'C'
    end
  end

  def check_achieve(src)
    case src
    when 'achieve4.png'.method(:in?)
      return 'all_marvelous'
    when 'achieve3.png'.method(:in?)
      return 'full_combo'
    when 'achieve2.png'.method(:in?)
      return 'missless'
    when 'achieve1.png'.method(:in?)
      return 'clear'
    else
      nil
    end
  end
end