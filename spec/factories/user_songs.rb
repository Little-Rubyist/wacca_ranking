FactoryBot.define do
  factory :user_song do
    user
    song
    is_favorite { false }
  end
end