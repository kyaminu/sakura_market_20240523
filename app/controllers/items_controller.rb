class ItemsController < ApplicationController
  def index
    @items = Item.published.default_order
  end

  def show
    @item = Item.published.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "この商品は現在取り扱っておりません"
    redirect_back(fallback_location: root_path)
  end
end
