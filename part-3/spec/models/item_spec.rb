require_relative "../spec_helper"

describe Item do
  describe "model associations" do
    before(:each) do
      @guy = FactoryGirl.create(:lister)
      @item = FactoryGirl.create(:item)
      @auction = FactoryGirl.create(:auction, { lister: @guy, item: @item })
    end

    it "returns the auction in which it's listed" do
      expect(@item.auction).to eq @auction
    end
  end
end
