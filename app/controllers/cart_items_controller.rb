class CartItemsController < ApplicationController
  def create
    item_id = params[:item_id].to_i
    quantity = params[:quantity].to_i
    session[:cart] << { item_id: item_id, quantity: quantity }

    redirect_to cart_path, notice: '商品がカートに追加されました'
    # session[:cart].clear
  end

  def update
  end

  def destroy
  end
end
