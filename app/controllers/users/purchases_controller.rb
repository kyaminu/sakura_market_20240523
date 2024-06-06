class Users::PurchasesController < Users::ApplicationController
  def new
    @purchase = current_user.purchases.new
  end

  def create
    ActiveRecord::Base.transaction do
      @purchase = current_user.purchases.build(purchase_params)
      @purchase.build_address
      @purchase.build_purchase_items
      @purchase.attach_item_image
    end

    if @purchase.save
      # TODO: まだ履歴画面作ってないので一旦ここに返す
      redirect_to root_path, notice: '商品を購入しました。'
      current_cart.cart_items.delete_all
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def purchase_params
      params.require(:purchase).permit(%i[delivery_fee handling_fee delivery_on delivery_time address_id])
    end
end
