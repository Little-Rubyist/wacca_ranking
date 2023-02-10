class ImportFromJson
  def initialize(user: nil, file: 'tmp/wacca_data.json')
    @user = user
    @json = JSON.parse(File.read(file))['player']
  end

  def import_stageup_score
    stageup_scores = []
    @json['stages'].each do |stage|
      next if stage['songs'].reject{|x| x['score'].zero?}.blank?

      stageup = Stageup.find(stage['id'])
      songs = {first: stageup.first_song.music_id,
               second: stageup.second_song.music_id,
               last: stageup.last_song.music_id}
      stageup_score = { user_id: 1,
                        stageup_id: stageup.id,
                        first_score: nil,
                        second_score: nil,
                        last_score: nil}
      stage['songs'].each do |song|
        next if song['id'].zero?

        score = songs.find{|_, v| v == song['id']}
        stageup_score["#{score[0]}_score".to_sym] = song['score']
      end
      stageup_scores << stageup_score
    end
    UserStageup.insert_all(stageup_scores)
  end

  def import_favorites
    update_ids = []
    @json['favorites'].each do |id|
      update_ids << UserSong.includes(:song)
                            .where(song: {music_id: id})
                            .where(user: @user)
                            .map(&:id)
    end
    UserSong.where(id: update_ids.flatten).update_all(is_favorite: true)
  end

  def import_scores
    @json['songs'].each do |song|
      user_songs = UserSong.includes(:song)
                           .where(song: {music_id: song['id']})
                           .where(user: @user)
      diff = {0 => :normal, 1 => :hard, 2 => :expert, 3 => :inferno}
      song['difficulties'].each_with_index do |score, i|
        user_song = user_songs.includes(:song).find_by(song: {diff_type: diff[i]})
        user_song.update(offline_count: score['playCount'])
        user_song.user_scores.create(is_offline: true,
                                     score: score['score'],
                                     achieve: convert_achieve(score['achieve']),
                                     played_on: Date.new(2022, 8, 31))
      end
    end
  end

  def import_trophies
    @json['trophies'].each do |version|
      version.filter{|trophy| trophy['unlocked']}.map{|trophy| @user.trophy << trophy['id']}
    end
    @user.save!
  end

  private

  def convert_achieve(achieve)
    case achieve
    when 1
      return :clear
    when 2
      return :missless
    when 3
      return :full_combo
    when 4
      return :all_marvelous
    else
      nil
    end
  end
end
