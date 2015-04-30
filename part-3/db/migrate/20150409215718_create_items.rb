class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title, { null: false }
      t.text :description, { null: false }
      t.integer :auction_id, { null: false }

      t.timestamps
    end

    add_index :items, :auction_id, { unique: true }
  end
end
