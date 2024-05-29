class Address < ApplicationRecord
  include JpPrefecture
  jp_prefecture :prefecture_code, method_name: :prefecture

  belongs_to :user

  validates :name, presence: true
  validates :phone_number, presence: true
  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :street, presence: true

  scope :default_order, -> { order(created_at: :desc) }
end
