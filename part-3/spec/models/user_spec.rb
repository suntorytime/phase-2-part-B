require_relative "../spec_helper"

describe User do
  describe "model associations" do
    before(:each) do
      @algernon = FactoryGirl.create(:user)
      @algernons_item = FactoryGirl.create(:item)
      @algernons_auction = FactoryGirl.create(:auction, { lister: @algernon, item: @algernons_item })

      @milton = FactoryGirl.create(:lister)
      @miltons_item = FactoryGirl.create(:item)
      @miltons_auction = FactoryGirl.create(:auction, { lister: @milton, item: @miltons_item })

      @algernons_bid = FactoryGirl.create(:bid, { bidder: @algernon, auction: @miltons_auction })
    end

    it "returns the auctions listed by the user" do
      expect(@algernon.auctions).to match_array [@algernons_auction]
    end

    it "returns the bids that the user has made" do
      expect(@algernon.bids).to match_array [@algernons_bid]
    end

    it "returns the items listed in auctions in which the user has placed a bid" do
      expect(@algernon.bid_on_items).to match_array [@miltons_item]
    end

    it "returns the items in auctions listed by the user" do
      expect(@algernon.listed_items).to match_array [@algernons_item]
    end
  end

  describe "additional model behaviors" do
    before(:each) do
      @tessie = FactoryGirl.create(:user)
      @past_auction = FactoryGirl.create(:past_auction, { lister: @tessie })
      @live_auction = FactoryGirl.create(:live_auction, { lister: @tessie })
      @future_auction = FactoryGirl.create(:future_auction, { lister: @tessie })
    end

    describe "#completed_auctions" do
      it "returns the auctions listed by the user that have ended" do
        expect(@tessie.completed_auctions).to match_array [@past_auction]
      end
    end

    describe "#live_auctions" do
      it "returns the auctions listed by the user that are currently running" do
        expect(@tessie.live_auctions).to match_array [@live_auction]
      end
    end

    describe "#scheduled_auctions" do
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
