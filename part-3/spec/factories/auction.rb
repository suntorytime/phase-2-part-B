FactoryGirl.define do
  factory(:auction) do
    start_date { Time.now - 1.day }
    end_date { Time.now + 2.days }

    factory(:auction_without_item) do
      association(:lister)
    end

    factory(:auction_without_lister) do
      after(:build) do |this_new_auction|
        build(:item, { auction: this_new_auction })
      end
    end

    factory(:auction_with_lister_and_item) do
      association :lister

      after(:build) do |this_new_auction|
        create(:item, { auction: this_new_auction })
      end

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
end
