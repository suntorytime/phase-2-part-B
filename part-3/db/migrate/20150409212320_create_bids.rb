class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.float :amount, {null: false, precision: 9, scale: 2 }
      t.integer :auction_id, { null: false }
      t.integer :bidder_id, { null: false }

      t.timestamps
    end

    add_index :bids, [:auction_id, :bidder_id], { unique: true }
    add_index :bids, :bidder_id
  end
end
