class CartItemsController < ApplicationController
  before_action :set_cart_item, only: %i[update destroy]

  def create
    @item = Item.find(params[:item_id])
    current_cart.cart_items.create!(item: @item)
    redirect_to cart_path, notice: t('controller.added')
  end

  def update
    @cart_item.update!(cart_item_params)
    redirect_to cart_path, notice: t('controller.changed')
  end

  def destroy
    @cart_item.destroy!
    redirect_to cart_path, notice: t('controller.destroyed'), status: :see_other
  end

  private

    def set_cart_item
      @cart_item = current_cart.cart_items.find(params[:id])
    end

    def cart_item_params
      params.require(:cart_item).permit(:quantity)
    end
end
