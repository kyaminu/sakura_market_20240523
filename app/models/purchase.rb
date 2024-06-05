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

  validates :delivery_fee, presence: true, numericality: { greater_than_or_equal_to: 600 }
  validates :handling_fee, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 900 }
  validates :delivery_on, presence: true
  validates :delivery_time, presence: true
  validates :name, presence: true
  validates :phone_number, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true

  scope :default_order, -> { order(created_at: :desc) }

  def delivery_fee_value
    delivery_fee = 600
    if user.cart.cart_items.count > 5
      delivery_fee += (user.cart.cart_items.count / 5) * 600
    end

    (delivery_fee * (1 + tax_rate)).floor
  end

  def handling_fee_value
    case user.cart.subtotal
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

  def total_value
    [user.cart.subtotal, delivery_fee_value, handling_fee_value].sum
  end
end
