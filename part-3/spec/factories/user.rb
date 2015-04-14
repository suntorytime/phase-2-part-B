FactoryGirl.define do
  factory(:user) do
    username { Faker::Internet::user_name }
    password "password"

    factory :bidder
    factory :lister
  end
end
