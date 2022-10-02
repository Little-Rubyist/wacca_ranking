class UserScore < ApplicationRecord
  belongs_to :user_song
  validates :score, presence: true, numericality: {only_integer: true, less_than_or_equal_to: 1000000}

  enum achieve: {
    clear: 0,
    missless: 1,
    full_combo: 2,
    all_marvelous: 3
  }
end
