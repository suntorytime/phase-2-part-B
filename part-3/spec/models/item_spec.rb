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

  describe "validations" do
    it "must have a title" do
      item_with_no_title = build(:item, { title: nil })
      expect(item_with_no_title).to_not be_valid
    end

    it "must have a description" do
      item_with_no_description = build(:item, { description: nil })
      expect(item_with_no_description).to_not be_valid
    end

    it "must have a condition" do
      item_with_no_condition = build(:item, { condition: nil })
      expect(item_with_no_condition).to_not be_valid
    end

    it "must have an appropriate condition" do
      item_with_unapproved_condition = build(:item, { condition: "you don't want to know" })
      expect(item_with_unapproved_condition).to_not be_valid
    end
  end
end
