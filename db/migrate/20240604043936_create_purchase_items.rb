class CreatePurchaseItems < ActiveRecord::Migration[7.1]
  def change
    create_table :purchase_items do |t|
      t.integer :item_id, null: false
      t.string :item_name, null: false
      t.string :item_description, null: false
      t.integer :item_price_excluding_tax, null: false
      t.decimal :item_tax_rate, default: 0.08, precision: 4, scale: 2, null: false
      t.integer :quantity, null: false
      t.references :purchase, null: false, foreign_key: true, index: { unique: true }

      t.timestamps
    end
  end
end
