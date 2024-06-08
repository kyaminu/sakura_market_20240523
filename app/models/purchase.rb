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
    ]
  attribute :delivery_time, :string, default: :time8_12
  attr_accessor :address_id

  validates :delivery_fee, presence: true, numericality: { greater_than_or_equal_to: 600 }
  validates :handling_fee, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 900 }
  validates :delivery_on, presence: true
  validates :delivery_time, presence: true
  validates :address_id, presence: true

  scope :default_order, -> { order(created_at: :desc) }

  def delivery_fee_value(item_count)
    delivery_fee = 600
    if item_count > 5
      delivery_fee += (item_count / 5) * 600
    end

    (delivery_fee * (1 + tax_rate)).floor
  end

  def purchase_item_subtotal
    purchase_items.sum { |purchase_item| (purchase_item.item_price_excluding_tax * (1 + purchase_item.item_tax_rate)).floor * purchase_item.quantity }
  end

  def handling_fee_value(subtotal)
    case subtotal
    when 1..9999
      handling_fee = 300
    when 10000..29999
      handling_fee = 400
    when 30000..99999
      handling_fee = 600
    else
      handling_fee = 1000
    end
    (handling_fee * (1 + tax_rate)).floor
  end

  def total_value(subtotal, delivery_fee, handling_fee)
    [subtotal, delivery_fee, handling_fee].sum
  end

  def build_purchase_items
    user.cart.cart_items.each do |cart_item|
      purchase_items.build(
        item_id: cart_item.item.id,
        item_name: cart_item.item.name,
        item_description: cart_item.item.description,
        item_price_excluding_tax: cart_item.item.price_excluding_tax,
        item_tax_rate: cart_item.item.tax_rate,
        quantity: cart_item.quantity
      )
    end
  end

  def build_address
    selected_address = user.addresses.find(address_id)

    if selected_address
      self.name = selected_address.name_kanji
      self.phone_number = selected_address.phone_number
      self.postal_code = selected_address.postal_code
      self.address = selected_address.full_address
    end
  end

  def attach_item_image
    user.cart.cart_items.each do |cart_item|
      purchase_items.each do |purchase_item|
        purchase_item.item_image.attach(cart_item.item.image.blob)
      end
    end
  end
end
