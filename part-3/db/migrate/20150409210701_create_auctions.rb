class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.date    :start_date, { null: false }
      t.date    :end_date, { null: false }
      t.integer :lister_id, { null: false, index: true }

      t.timestamps
    end
  end
end
