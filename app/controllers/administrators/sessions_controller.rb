# frozen_string_literal: true

class Administrators::SessionsController < Devise::SessionsController
  layout 'administrators/application'

  def after_sign_in_path_for(resource)
    administrators_root_path
  end

  def after_sign_out_path_for(resource)
    new_administrator_session_path
  end
end
