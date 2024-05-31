class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_cart

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def current_cart
    if user_signed_in?
      current_user.cart
    else
      cart = Cart.create!
      session[:cart_id] = cart.id
      cart
    end
  end
end
