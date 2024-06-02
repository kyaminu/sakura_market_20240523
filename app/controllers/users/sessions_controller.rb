class Users::SessionsController < Devise::SessionsController
  def create
    super

    session_cart = Cart.find(session[:cart_id])
    session_cart.cart_items.each do |session_item|
      user_cart_item = current_user.cart.cart_items.find_by(item_id: session_item.item_id)

      if user_cart_item
        user_cart_item.quantity += session_item.quantity
        user_cart_item.save
      else
        current_user.cart.cart_items << CartItem.new(item_id: session_item.item_id, quantity: session_item.quantity)
      end
    end
  end

  def destroy
    super
    reset_session
  end
end
