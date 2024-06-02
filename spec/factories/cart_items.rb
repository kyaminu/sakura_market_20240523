FactoryBot.define do
  factory :cart_item do
    cart
    item
    quantity { 1 }
  end
end
