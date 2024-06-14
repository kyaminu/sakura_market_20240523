class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item

  validates :cart_id, uniqueness: { scope: :item_id }
  validates :quantity, presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 20  }

  scope :default_order, -> { order(:created_at) }
end
