class Administrators::ApplicationController < ActionController::Base
  before_action :authenticate_administrator!
end
