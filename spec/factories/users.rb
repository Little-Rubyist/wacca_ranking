FactoryBot.define do
  factory :user do
    name { "user_#{User.next_id}" }
    display_name { "user_#{User.next_id}_name" }
    password { 'password' }
  end
end
