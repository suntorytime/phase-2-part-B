require_relative "../spec_helper"

describe Auction do
  describe "model associations", { auction_associations: true } do
    it "returns the listed item" do
      lamp = FactoryGirl.build(:item)
      auction = FactoryGirl.build(:auction, { item: lamp })

      expect(auction.item).to eq lamp
    end

    it "returns the user who listed the auction" do
      tom = FactoryGirl.build(:lister)
      auction = FactoryGirl.build(:auction, { lister: tom })

      expect(auction.lister).to eq tom
    end

    it "returns the bids placed" do
      bids = [FactoryGirl.build(:bid), FactoryGirl.build(:bid)]
      auction = FactoryGirl.build(:auction, { bids: bids })

      expect(auction.bids).to match_array bids
    end

    it "returns the users who've bid" do
      jodie = FactoryGirl.build(:bidder)
      auction = FactoryGirl.build(:auction, { bidders: [jodie] })

      expect(auction.bidders).to match_array [jodie]
    end
  end

  describe "additional model behaviors", { auction_behaviors: true } do
    describe "class behaviors" do
      before(:each) do
        @past_auction = FactoryGirl.create(:past_auction)
        @live_auction = FactoryGirl.create(:live_auction)
        @future_auction = FactoryGirl.create(:future_auction)
      end

      describe ".completed" do
        it "returns all the auctions that have ended" do
          expect(Auction.completed).to match_array [@past_auction]
        end
      end

      describe ".live" do
        it "returns all the auctions currently running" do
          expect(Auction.live).to match_array [@live_auction]
        end
      end

      describe ".scheduled" do
        it "returns all the auctions that have yet to begin" do
          expect(Auction.scheduled).to match_array [@future_auction]
        end
      end
    end
  end

  describe "validations", { auction_validations: true } do
    it "can be valid" do
      valid_auction = FactoryGirl.build(:auction_with_lister_and_item)
      expect(valid_auction).to be_valid
    end

    it "item must exist" do
      auction = build(:auction_without_item)
      expect(auction).to_not be_valid
    end

    it "lister must exist" do
      auction = build(:auction_without_lister)
      expect(auction).to_not be_valid
    end

    it "must have a start date" do
      auction = build(:auction_with_lister_and_item)
      expect(auction).to be_valid

      auction.start_date = nil
      expect(auction).to_not be_valid
    end

    it "must have an end date" do
      auction = build(:auction_with_lister_and_item)
      expect(auction).to be_valid

      auction.end_date = nil
      expect(auction).to_not be_valid
    end

    it "end date and time must be later than start date and time" do
      auction = build(:auction_with_lister_and_item)
      expect(auction).to be_valid

      auction.end_date = auction.start_date - 5.days
      expect(auction).to_not be_valid
    end
  end
end
