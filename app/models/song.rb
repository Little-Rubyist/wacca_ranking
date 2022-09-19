class Song < ApplicationRecord
  has_many :user_songs
  has_many :users, through: :user_songs
  validates :title, presence: true
  validates :music_id, presence: true

  enum genre: {
    anime_pop: 1,
    vocaloid: 2,
    touhou: 3,
    '2_5_dimension': 4,
    variety: 5,
    original: 6,
    tanoc: 7
  }

  enum diff_type: {
    normal: 1,
    hard: 2,
    expert: 3,
    inferno: 4
  }
end
