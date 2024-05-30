class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy

  def subtotal
    cart_items.sum { |cart_item| cart_item.item.price_excluding_tax * cart_item.item.tax_rate * cart_item.quantity }
  end
end
