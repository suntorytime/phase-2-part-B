class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.datetime :starts_at, { null: false }
      t.datetime :ends_at, { null: false }
      t.integer :lister_id, { null: false, index: true }
      t.integer :item_id { null: false, index: true }

      t.timestamps
    end
  end
end
