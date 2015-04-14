FactoryGirl.define do
  factory(:auction) do
    association :item
    association :lister
    starts_at { Time.now - 1.day }
    ends_at { Time.now + 2.days }

    factory(:past_auction) do
      starts_at { Time.now - 10.days }
      ends_at { Time.now - 8.days }
    end

    factory(:live_auction)

    factory(:future_auction) do
      starts_at { Time.now + 5.days }
      ends_at { Time.now + 7.days }
    end
  end
end
