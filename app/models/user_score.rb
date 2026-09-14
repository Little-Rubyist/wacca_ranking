class UserScore < ApplicationRecord
  belongs_to :user_song
  validates :score, presence: true, numericality: {only_integer: true, less_than_or_equal_to: 1000000}

  enum achieve: {
    clear: 0,
    missless: 1,
    full_combo: 2,
    all_marvelous: 3
  }

  # ransack 4系では検索対象の属性・関連を明示的に許可する必要がある
  def self.ransackable_attributes(auth_object = nil)
    %w[achieve score]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
