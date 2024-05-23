class Administration::ApplicationController < ActionController::Base
  before_action :authenticate_administration!
end
