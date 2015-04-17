class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.date    :starts_at, { null: false }
      t.date    :ends_at, { null: false }
      t.integer :lister_id, { null: false, index: true }
      t.integer :item_id, { null: false, index: true }

      t.timestamps
    end
  end
end
