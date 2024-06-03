class Users::SessionsController < Devise::SessionsController
  def create
    super

    session_cart = Cart.find(session[:cart_id])
    current_user.merge_cart(session_cart)
    session[:cart_id] = nil
  end
end
