class Stageup < ApplicationRecord
  belongs_to :first_song, class_name: 'Song', foreign_key: 'first_song_id'
  belongs_to :second_song, class_name: 'Song', foreign_key: 'second_song_id'
  belongs_to :last_song, class_name: 'Song', foreign_key: 'last_song_id'
end
