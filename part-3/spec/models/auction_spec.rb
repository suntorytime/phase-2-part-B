require_relative "../spec_helper"

describe Auction do
  describe "model associations" do
    before(:all) do
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
end
