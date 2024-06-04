class PurchaseItem < ApplicationRecord
  belongs_to :purchase

  has_one_attached :item_image do |attachable|
    attachable.variant(:thumb, resize_to_fill: [120, 80])
  end

  validates :purchase_id, uniqueness: true
  validates :item_id, presence: true
  validates :item_name, presence: true
  validates :item_description, presence: true
  validates :item_price_excluding_tax, presence: true
  validates :item_tax_rate, presence: true
  validates :quantity, presence: true

  scope :default_order, -> { order(:item_id) }
end
