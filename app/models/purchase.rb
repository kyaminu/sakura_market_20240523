class Purchase < ApplicationRecord
  extend Enumerize

  belongs_to :user, optional: true
  has_many :purchase_items

  enumerize :delivery_time, in:
    %i[
      time8_12
      time12_14
      time14_16
      time16_18
      time18_20
      time20_21
    ],default: :time8_12

  validates :delivery_fee, presence: true, numericality: { greater_than_or_equal_to: 600 }
  validates :handling_fee, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 900 }
  validates :delivery_on, presence: true
  validates :delivery_time, presence: true
  validates :name, presence: true
  validates :phone_number, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true

  scope :default_order, -> { order(created_at: :desc) }
end
