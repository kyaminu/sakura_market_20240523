# frozen_string_literal: true

class Administrations::SessionsController < Devise::SessionsController
  layout 'administration/application'

  def after_sign_in_path_for(resource)
    administrations_root_path
  end

  def after_sign_out_path_for(resource)
    new_administration_session_path
  end
end
