FactoryGirl.define do
  factory(:auction) do
    association :item
    association :lister
    starts_at { Faker::Time.backward(1) }
    ends_at { Faker::Time.forward(3) }

    factory(:past_auction) do
      starts_at { Faker::Time.backward(10) }
      ends_at { Faker::Time.backward(8) }
    end

    factory(:live_auction)

    factory(:future_auction) do
      starts_at { Faker::Time.forward(5) }
      ends_at { Faker::Time.forward(6) }
    end
  end
end
