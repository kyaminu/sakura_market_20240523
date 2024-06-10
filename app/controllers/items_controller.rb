class ItemsController < ApplicationController
  def index
    @items = Item.published.default_order.with_attached_image
  end

  def show
    @item = Item.published.find(params[:id])
  end
end
