require_relative "../spec_helper"

describe Bid do
  describe "model associations" do
    it "returns the auction in which the bid was placed" do
      auction = FactoryGirl.build(:auction)
      bid = FactoryGirl.build(:bid, { auction: auction })

      expect(bid.auction).to eq auction
    end

    it "returns the user who placed the bid" do
      erma = FactoryGirl.build(:bidder)
      bid = FactoryGirl.build(:bid, { bidder: erma })

      expect(bid.bidder).to eq erma
    end
  end

  describe "validations" do
    it "auction must exist" do
      bid_with_no_auction = build(:bid, { auction: nil })
      expect(bid_with_no_auction).to_not be_valid
    end

    it "bidder must exist" do
      bid_with_no_bidder = build(:bid, { bidder: nil })
      expect(bid_with_no_bidder).to_not be_valid
    end

    it "must have an amount" do
      bid_with_no_amount = build(:bid, { amount: nil })
      expect(bid_with_no_amount).to_not be_valid
    end

    it "a user can have only one bid per auction" do
      josephina = FactoryGirl.create(:bidder)
      auction = FactoryGirl.create(:auction)
      original_bid = FactoryGirl.create(:bid, { bidder: josephina, auction: auction })
      repeat_bid = build(:bid, { bidder: josephina, auction: auction })
      expect(repeat_bid).to_not be_valid
    end

    it "A user cannot bid in an auction they listed" do
      kristie = FactoryGirl.create(:lister)
      auction = FactoryGirl.create(:auction, { lister: kristie })
      bid_in_own_auction = build(:bid, { bidder: kristie, auction: auction })
      expect(bid_in_own_auction).to_not be_valid
    end
  end
end
