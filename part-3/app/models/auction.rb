class Auction < ActiveRecord::Base
  belongs_to :item
  belongs_to :lister, class_name: "User"
  has_many :bids
  has_many :bidders, through: :bids
end
