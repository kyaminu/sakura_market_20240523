class ItemsController < ApplicationController
  def index
    @items = Item.published.default_order
  end

  def show
    @item = Item.published.find(params[:id])
  end
end
