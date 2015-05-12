FactoryGirl.define do
  factory(:bid) do
    amount 20.00

    factory(:bid_without_auction) do
      association :bidder
    end

    factory(:bid_with_bidder_and_auction) do
      association :bidder

      after(:build) do |this_new_bid|
        build(:auction_with_lister_and_item, { bids: [this_new_bid] })
      end
    end
  end
end
