require_relative "../spec_helper"

describe Auction do
  describe "model associations" do
    before(:each) do
      @tom = FactoryGirl.create(:user, { username: "tom" })
      @jodie = FactoryGirl.create(:user, { username: "jodie" })

      @lamp = FactoryGirl.create(:item, { title: "lamp" })

      @auction = FactoryGirl.create(:auction, { lister: @tom, item: @lamp })

      @bid = FactoryGirl.create(:bid, { bidder: @jodie, auction: @auction })
    end

    it "returns the listed item" do
      expect(@auction.item).to eq @lamp
    end

    it "returns the user who listed the auction" do
      expect(@auction.lister).to eq @tom
    end

    it "returns the bids placed" do
      expect(@auction.bids).to match_array [@bid]
    end

    it "returns the users who've bid" do
      expect(@auction.bidders).to match_array [@jodie]
    end
  end

  describe "additional model behaviors" do
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

    describe "instance behaviors" do
      before(:each) do
        @juan = FactoryGirl.create(:user)
        @sally = FactoryGirl.create(:user)

        @auction = FactoryGirl.create(:auction)

        @high_bid = FactoryGirl.create(:bid, { amount: 50.00, auction: @auction, bidder: @juan })
        @low_bid = FactoryGirl.create(:bid, { amount: 10.00, auction: @auction, bidder: @sally })
      end

      describe "#highest_bid" do
        it "returns the highest bid for the auction" do
          expect(@auction.highest_bid).to eq @high_bid
        end
      end

      describe "#highest_bidder" do
        it "returns the user who placed the highest bid for the auction" do
          expect(@auction.highest_bidder).to eq @juan
        end
      end
    end

    describe "validations" do
      it "item must exist" do
        auction_without_an_item = build(:auction, { item: nil })
        expect(auction_without_an_item).to_not be_valid
      end

      it "lister must exist" do
        auction_without_a_lister = build(:auction, { lister: nil })
        expect(auction_without_a_lister).to_not be_valid
      end

      it "must have a start date and time" do
        auction_without_starts_at = build(:auction, { starts_at: nil })
        expect(auction_without_starts_at).to_not be_valid
      end

      it "must have an end date and time" do
        auction_without_ends_at = build(:auction, { ends_at: nil })
        expect(auction_without_ends_at).to_not be_valid
      end

      it "end date and time must be later than start date and time" do
        auction_with_ends_at_before_starts_at = build(:auction, { starts_at: Time.now, ends_at: Faker::Time.backward(5) })
        expect(auction_with_ends_at_before_starts_at).to_not be_valid
      end
    end
  end
end
