FactoryGirl.define do
  factory(:auction) do
    association :item
    association :lister
    starts_at { Faker::Time.backward(1) }
    ends_at { Faker::Time.forward(3) }
  end
end
