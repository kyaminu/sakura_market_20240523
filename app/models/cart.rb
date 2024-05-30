class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy

  def subtotal
    cart_items.sum { |cart_item| cart_item.item.price_included_tax * cart_item.quantity }
  end

  def is_in?(item)
    cart_items.exists?(item_id: item)
  end
end