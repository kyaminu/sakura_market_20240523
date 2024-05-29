class ItemsController < ApplicationController
  def index
    @items = Item.published.default_order
  end

  def show
  end
end
