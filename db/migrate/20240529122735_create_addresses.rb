class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name_kanji, null: false
      t.string :name_kana, null: false
      t.string :phone_number, null: false
      t.string :postal_code, null: false
      t.integer :prefecture_code, null: false
      t.string :city, null: false
      t.string :street, null: false, default: ''

      t.timestamps
    end
  end
end
