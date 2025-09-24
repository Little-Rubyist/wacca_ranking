FactoryBot.define do
  factory :user_score do
    association :user_song
    score { 900000 }
    achieve { 'clear' }
    played_on { Date.current }
  end
end