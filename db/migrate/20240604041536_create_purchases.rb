class CreatePurchases < ActiveRecord::Migration[7.1]
  def change
    create_table :purchases do |t|
      t.integer :delivery_fee, null: false
      t.integer :handling_fee, null: false
      t.decimal :tax_rate, null: false, default: 0.1, precision: 4, scale: 2
      t.date :delivery_on, null: false
      t.string :delivery_time, null: false
      t.string :name, null: false
      t.string :phone_number, null: false
      t.string :postal_code, null: false
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :street, null: false
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
