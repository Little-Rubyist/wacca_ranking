FactoryBot.define do
  factory :song do
    sequence(:title) { |n| "Test Song #{n}" }
    sequence(:music_id) { |n| n }
    difficulty { rand(1.0..15.0).round(1) }
    genre { Song.genres.keys.sample }
    diff_type { Song.diff_types.keys.sample }
    can_play_offline { [true, false].sample }
  end
end