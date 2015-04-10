require_relative "../spec_helper"

describe Auction do
  describe "model associations" do
    before(:each) do
      @tom = create(:user, { username: "tom" })
      @jodie = create(:user, { username: "jodie" })

      @lamp = create(:item, { title: "lamp" })

      @auction = create(:auction, { lister: @tom, item: @lamp })

      @bid = create(:bid, { bidder: @jodie, auction: @auction })
    end

    it "returns the bids placed" do
      expect(@auction.bids).to match_array [@bid]
    end

    it "returns the users who've bid" do
      expect(@auction.bidders).to match_array [@jodie]
    end

    it "returns the listed item" do
      expect(@auction.item).to eq @lamp
    end

    it "returns the user who listed the auction" do
      expect(@auction.lister).to eq @tom
    end
  end

  describe "additional model behaviors" do
    before(:each) do
      @past_auction = create(:past_auction)
      @live_auction = create(:live_auction)
      @future_auction = create(:future_auction)
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
