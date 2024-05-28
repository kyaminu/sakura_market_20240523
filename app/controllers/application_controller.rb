class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_cart_with_items

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def current_cart_with_items
    if user_signed_in?
      current_user.cart.cart_items
    else
      session[:cart] ||= []
    end
  end
end
