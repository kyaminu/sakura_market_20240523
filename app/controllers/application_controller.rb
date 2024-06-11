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
      find_or_create_cart
    end
  end

  private

    def find_or_create_cart
      session_cart_id = session[:cart_id]
      if session_cart_id.present?
        Cart.find_by(id: session_cart_id) || create_cart
      else
        create_cart
      end
    end

    def create_cart
      cart = Cart.create!
      session[:cart_id] = cart.id
      cart
    end
end
