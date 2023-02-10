class ImportFromJson
  def initialize(user: nil, file: 'tmp/wacca_data.json')
    @user = user
    @json = JSON.parse(File.read(file))['player']
  end

  def import_trophies
    @json['trophies'].each do |version|
      version.filter{|trophy| trophy['unlocked']}.map{|trophy| @user.trophy << trophy['id']}
    end
    @user.save!
  end
end
