# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super

    if session[:cart_id].present?
      cart = Cart.find(session[:cart_id])
      cart.update!(user_id: current_user.id)
    else
      current_user.create_cart!
    end

    session[:cart_id] = nil
  end

  protected

    def update_resource(resource, params)
      resource.update_without_password(params)
    end
end
