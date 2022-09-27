require 'csv'
require 'tempfile'

class ImportScoreFromCsv
  def initialize(user, file)
    Tempfile.create do |t|
      text_csv = File.read(file)
      text_csv.gsub!(/\"593: Insanely Fluctuated\"/, '""593: Insanely Fluctuated""')
      t.write text_csv

      import_data = []
      CSV.foreach(t.path, headers: true ,liberal_parsing: true) do |score|
        next if score[4] == '0'
        diff_type = score[3][/([A-Z]+)/, 1].downcase.to_sym
        song = Song.where(title: score[2]).find_by(diff_type: diff_type)
        user_song = user.user_songs.find_by(song_id: song.id)
        # user_song.user_scores.create(score: score[4], achieve: is_all_marvelous?(score[4]))
        import_data << {user_song_id: user_song.id,
                        score: score[4],
                        achieve: is_all_marvelous?(score[4])}
      end
      UserScore.insert_all(import_data)
    end
  end

  def is_all_marvelous?(score)
    if score == '1000000'
      :all_marvelous
    else
      :clear
    end
  end
end
