class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :description, null: false
      t.integer :price_excluding_tax, null: false
      t.boolean :published, null: false, default: false
      t.integer :position, null: false, default: 1
      t.decimal :tax_rate, null: false, default: 0.08, precision: 4, scale: 2

      t.timestamps
    end
  end
end
