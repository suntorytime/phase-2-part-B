FactoryGirl.define do
  factory(:auction) do
    start_date { Time.now - 1.day }
    end_date { Time.now + 2.days }

    factory(:past_auction) do
      start_date { Time.now - 10.days }
      end_date { Time.now - 8.days }
    end

    factory(:live_auction)

    factory(:future_auction) do
      start_date { Time.now + 5.days }
      end_date { Time.now + 7.days }
    end
  end
end
