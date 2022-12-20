class ImportFromJson
  def initialize(user: nil, file: 'tmp/wacca_data.json')
    json = JSON.parse(File.read(file))
    pp json['player']['color']
  end
end
