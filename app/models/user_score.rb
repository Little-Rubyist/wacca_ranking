class UserScore < ApplicationRecord
  belongs_to :user_song

  enum achieve: {
    clear: 0,
    missless: 1,
    full_combo: 2,
    all_marvelous: 3
  }
end