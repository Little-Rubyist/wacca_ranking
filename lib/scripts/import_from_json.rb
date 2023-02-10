class ImportFromJson
  def initialize(user: nil, file: 'tmp/wacca_data.json')
    @user = user
    @json = JSON.parse(File.read(file))['player']
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

  def import_trophies
    @json['trophies'].each do |version|
      version.filter{|trophy| trophy['unlocked']}.map{|trophy| @user.trophy << trophy['id']}
    end
    @user.save!
  end
end
