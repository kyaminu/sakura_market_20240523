class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :purchases
  has_many :addresses, dependent: :destroy
  has_one :cart, dependent: :destroy

  validates :email, presence: true

  scope :default_order, -> { order(:id) }

  def update_without_password(params, *options)
    if params.delete(:password) && params.delete(:password_confirmation).blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end

  def merge_cart(session_cart)
    ActiveRecord::Base.transaction do
      session_cart.cart_items.each do |session_item|
        merge_cart_item(session_item)
      end
    end
  end

  private

    def merge_cart_item(session_item)
      user_cart_item = cart.cart_items.find_by(item_id: session_item.item_id)

      if user_cart_item
        user_cart_item.quantity += session_item.quantity
        user_cart_item.save!
      else
        cart.cart_items.create!(item_id: session_item.item_id, quantity: session_item.quantity)
      end
    end
end
