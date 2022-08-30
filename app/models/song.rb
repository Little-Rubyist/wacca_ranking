class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :song_id, presence: true

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