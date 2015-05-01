require_relative "../spec_helper"

describe Bid do
  describe "model associations", { bid_associations: true } do
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
    it "can be valid" do
      bid = FactoryGirl.build(:bid_with_bidder_and_auction)
      expect(bid).to be_valid
    end

    it "must have an amount" do
      bid = FactoryGirl.build(:bid_with_bidder_and_auction)
      expect(bid).to be_valid

      bid.amount = nil
      expect(bid).to_not be_valid
    end

    it "auction must exist" do
      bid = FactoryGirl.build(:bid_without_auction)
      expect(bid).to_not be_valid

      bid.auction = FactoryGirl.build(:auction_with_lister_and_item)
      expect(bid).to be_valid
    end

    it "bidder must exist" do
      bid = FactoryGirl.build(:bid)
      bid.auction = FactoryGirl.build(:auction_with_lister_and_item)
      expect(bid).to_not be_valid

      bid.bidder = FactoryGirl.build(:bidder)
      expect(bid).to be_valid
    end

    it "a user can have only one bid per auction" do
      josephina = FactoryGirl.build(:bidder)
      clothes_auction = FactoryGirl.build(:auction_with_lister_and_item)

      original_clothes_bid = FactoryGirl.create(:bid, { bidder: josephina, auction: clothes_auction })
      expect(original_clothes_bid).to be_valid

      repeat_clothes_bid = FactoryGirl.build(:bid, { bidder: josephina, auction: clothes_auction })
      expect(repeat_clothes_bid).to_not be_valid

      tools_auction = FactoryGirl.build(:auction_with_lister_and_item)
      tools_auction_bid = FactoryGirl.build(:bid, { bidder: josephina, auction: tools_auction })
      expect(tools_auction_bid).to be_valid
    end

    it "A user cannot bid in an auction they listed" do
      kristie = FactoryGirl.build(:lister)
      kristies_auction = FactoryGirl.build(:auction_with_lister_and_item, { lister: kristie })

      bid_from_lister = FactoryGirl.build(:bid, { bidder: kristie, auction: kristies_auction })
      expect(bid_from_lister).to_not be_valid

      gale = FactoryGirl.build(:bidder)
      bid_from_other_user = FactoryGirl.build(:bid, { bidder: gale, auction: kristies_auction })
      expect(bid_from_other_user).to be_valid
    end
  end
end
