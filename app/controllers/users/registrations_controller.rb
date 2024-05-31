# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
    cart = Cart.find(session[:cart_id])
    cart.update!(user_id: current_user.id)
  end

  def destroy
    super
    session[:cart_id].clear
  end

  protected
    def update_resource(resource, params)
      resource.update_without_password(params)
    end
end
