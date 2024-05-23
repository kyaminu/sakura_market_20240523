# frozen_string_literal: true

class Administration::SessionsController < Devise::SessionsController
  layout 'administration/application'

  def after_sign_in_path_for(resource)
    # TODO: ログイン後のパスに変える
  end

  def after_sign_out_path_for(resource)
    # TODO: ログイン画面のパスに変える
  end
end
