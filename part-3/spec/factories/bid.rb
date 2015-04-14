FactoryGirl.define do
  factory(:bid) do
    amount 20.00
    association :auction
    association :bidder
  end
end
