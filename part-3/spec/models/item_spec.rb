require_relative "../spec_helper"

describe Item do
  describe "model associations", { item_associations: true } do
    it "returns the auction in which it's listed" do
      trading_card_auction = FactoryGirl.build(:auction)
      item = FactoryGirl.build(:item, { auction: trading_card_auction })

      expect(item.auction).to eq trading_card_auction
    end
  end
end
