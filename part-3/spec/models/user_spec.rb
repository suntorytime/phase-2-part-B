require_relative "../spec_helper"

describe User do
  describe "model associations", { user_associations: true } do
    it "returns the auctions listed by the user" do
      algernon = FactoryGirl.build(:lister)
      algernons_auction = FactoryGirl.create(:auction_with_lister_and_item, { lister: algernon })

      expect(algernon.listed_auctions).to match_array [algernons_auction]
    end

    it "returns the bids that the user has made" do
      algernon = FactoryGirl.build(:bidder)
      algernons_bid = FactoryGirl.create(:bid_with_bidder_and_auction, { bidder: algernon })

      expect(algernon.bids).to match_array [algernons_bid]
    end

    it "returns the auctions for which the user has placed a bid" do
      miltons_auction = FactoryGirl.build(:auction)
      algernon = FactoryGirl.build(:bidder, { bid_in_auctions: [miltons_auction] })

      expect(algernon.bid_in_auctions).to match_array [miltons_auction]
    end
  end

  describe "additional model behaviors" do
    before(:each) do
      @tessie = FactoryGirl.create(:user)
      @past_auction = FactoryGirl.create(:past_auction, { lister: @tessie })
      @live_auction = FactoryGirl.create(:live_auction, { lister: @tessie })
      @future_auction = FactoryGirl.create(:future_auction, { lister: @tessie })
    end

    describe "#completed_listed_auctions" do
      it "returns the auctions listed by the user that have ended" do
        expect(@tessie.completed_listed_auctions).to match_array [@past_auction]
      end
    end

    describe "#live_listed_auctions" do
      it "returns the auctions listed by the user that are currently running" do
        expect(@tessie.live_listed_auctions).to match_array [@live_auction]
      end
    end

    describe "#scheduled_listed_auctions" do
      it "returns the auctions listed by the user that have yet to begin" do
        expect(@tessie.scheduled_listed_auctions).to match_array [@future_auction]
      end
    end
  end

  describe "validations" do
    it "must have a username" do
      godfrey = FactoryGirl.build(:user)
      expect(godfrey).to be_valid

      godfrey.username = nil
      expect(godfrey).to_not be_valid
    end

    it "must have a unique username" do
      davey = FactoryGirl.create(:user, { username: "davey" })
      second_davey = build(:user, { username: "davey" })
      expect(second_davey).to_not be_valid

      second_davey.username = "official_davey"
      expect(second_davey).to be_valid
    end
  end
end
