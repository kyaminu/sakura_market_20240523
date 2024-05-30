class CartsController < ApplicationController
  def show
    @cart = Cart.find_by(user_id: current_user.id)
    @cart_items = @cart.cart_items.default_order
  end
end
