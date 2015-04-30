require_relative "../spec_helper"

describe User do
  describe "model associations" do
    it "returns the auctions listed by the user" do
      algernons_auction = FactoryGirl.build(:auction)
      algernon = FactoryGirl.create(:lister, { listed_auctions: [algernons_auction] })

      expect(algernon.listed_auctions).to match_array [algernons_auction]
    end

    it "returns the bids that the user has made" do
      milton = FactoryGirl.build(:lister)
      miltons_auction = FactoryGirl.build(:auction, { lister: milton })
      algernons_bid = FactoryGirl.build(:bid, { auction: miltons_auction })
      algernon = FactoryGirl.create(:bidder, { bids: [algernons_bid] })

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
        expect(@tessie.completed_auctions).to match_array [@past_auction]
      end
    end

    describe "#live_listed_auctions" do
      it "returns the auctions listed by the user that are currently running" do
        expect(@tessie.live_auctions).to match_array [@live_auction]
      end
    end

    describe "#scheduled_listed_auctions" do
      it "returns the auctions listed by the user that have yet to begin" do
        expect(@tessie.scheduled_auctions).to match_array [@future_auction]
      end
    end
  end

  describe "validations" do
    it "must have a username" do
      user_with_no_username = build(:user, { username: nil })
      expect(user_with_no_username).to_not be_valid
    end

    it "must have a unique username" do
      davey = FactoryGirl.create(:user, { username: "Davey" })
      second_davey = build(:user, { username: "Davey" })
      expect(second_davey).to_not be_valid
    end

    it "must choose a password that is at least eight characters long" do
      user_with_short_password = build(:user, { password: "1short7" })
      expect(user_with_short_password).to_not be_valid
    end
  end
end
