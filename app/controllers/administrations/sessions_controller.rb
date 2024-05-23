# frozen_string_literal: true

class Administrations::SessionsController < Devise::SessionsController
  layout 'administration/application'

  def after_sign_in_path_for(resource)
    # TODO: ログイン後のパスに変える
  end

  def after_sign_out_path_for(resource)
    # TODO: ログイン画面のパスに変える
  end
end
