require_relative "../spec_helper"

describe Bid do
  describe "model associations" do
    before(:each) do
      @erma = create(:bidder, { username: "Erma" })
      @emilia = create(:lister, { username: "Emilia" })
      @item = create(:item)
      @auction = create(:auction, { lister: @emilia, item: @item })

      @bid = create(:bid, { auction: @auction, bidder: @erma })
    end

    it "returns the auction in which the bid was placed" do
      expect(@bid.auction).to eq @auction
    end

    it "returns the user who placed the bid" do
      expect(@bid.bidder).to eq @erma
    end

    it "returns the item in the auction in which the bid was placed" do
      expect(@bid.item).to eq @item
    end

    it "returns the user who listed the auction in which the bid was placed" do
      expect(@bid.receiver).to eq @emilia
    end
  end

  describe "additional model behaviors" do
    before(:each) do
      @major = create(:bidder)
      @caren = create(:bidder)

      @high_bid = create(:bid, { amount: 100.00, bidder: @major })
      @low_bid = create(:bid, { amount: 1.00, bidder: @caren })
    end

    describe ".highest" do
      it "returns the bid with the highest amount" do
        expect(Bid.highest).to eq @high_bid
      end
    end

    describe ".highest_bidder" do
      it "returns the user who placed the highest bid" do
        expect(Bid.highest_bidder).to eq @major
      end
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
      josephina = create(:bidder)
      auction = create(:auction)
      original_bid = create(:bid, { bidder: josephina, auction: auction })
      repeat_bid = build(:bid, { bidder: josephina, auction: auction })
      expect(repeat_bid).to_not be_valid
    end

    it "A user cannot bid in an auction they created" do
      kristie = create(:lister)
      auction = create(:auction, { lister: kristie })
      bid_in_own_auction = build(:bid, { bidder: kristie, auction: auction })
      expect(bid_in_own_auction).to_not be_valid
    end
  end
end
