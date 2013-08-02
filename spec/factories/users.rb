FactoryGirl.define do
  factory :user do
    full_name { Faker::Name.name }
    display_name { Faker::Name.name }
    provider "Fitbit"
    uid { rand(111111..999999) }
    oauth_token { SecureRandom.hex }
    oauth_token_secret { SecureRandom.hex }
  end
end
