class Address < ApplicationRecord
  include JpPrefecture
  jp_prefecture :prefecture_code

  belongs_to :user

  validates :name_kanji, presence: true
  validates :name_kana, presence: true
  validates :phone_number, presence: true
  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :prefecture_code, presence: true
  validates :city, presence: true
  validates :street, presence: true

  scope :default_order, -> { order(created_at: :desc) }
end
