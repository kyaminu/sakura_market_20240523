class Users::SessionsController < Devise::SessionsController
  def create
    session[:cart_id] = nil
  end
end
