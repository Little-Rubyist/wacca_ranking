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

  # ransack 4系では検索対象の属性・関連を明示的に許可する必要がある
  def self.ransackable_attributes(auth_object = nil)
    %w[difficulty diff_type genre title title_english can_play_offline]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
