class ImportScoreFromHtml
  def initialize
    html = File.read('tmp/wacca_mypage.htm')
    page = Nokogiri::HTML.parse(html, nil)

    list = page.xpath('/html/body/div[1]/div/section/div[2]/div[3]/ul')
    list.each do |song|
      base_data = song.at_css('.item')
      music_id = song.at_css('form').attribute('name').text.match(/detail([0-9]*)/)[1]
      title = song.at('.playdata__score-list__song-info__name').text
      normal_level = base_data.attribute('data-rank_normal_level').text
      hard_level = base_data.attribute('data-rank_hard_level').text
      expert_level = base_data.attribute('data-rank_expert_level').text
      inferno_level = base_data.attribute('data-rank_inferno_level').text
      normal_score = base_data.attribute('data-rank_normal_score').text
      hard_score = base_data.attribute('data-rank_hard_score').text
      expert_score = base_data.attribute('data-rank_expert_score').text
      inferno_score = base_data.attribute('data-rank_inferno_score').text
      normal_achieve = find_achieve_src(song, 'normal')
      hard_achieve = find_achieve_src(song, 'hard')
      expert_achieve = find_achieve_src(song, 'expert')
      inferno_achieve = find_achieve_src(song, 'inferno')
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
      return 'AM'
    when 'achieve3.png'.method(:in?)
      return 'FC'
    when 'achieve2.png'.method(:in?)
      return 'ML'
    when 'achieve1.png'.method(:in?)
      return 'clear'
    end
  end
end