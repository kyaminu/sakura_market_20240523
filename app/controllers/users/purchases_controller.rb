class Users::PurchasesController < Users::ApplicationController
  def index
    @purchases = current_user.purchases.default_order
  end

  def new
    @purchase = current_user.purchases.new
    @purchase.cart = current_cart
  end

  def show
    @purchase = current_user.purchases.find(params[:id])
  end

  def create
    @purchase = current_user.purchases.build(purchase_params)
    if @purchase.purchase_items_from_cart(current_cart)
      redirect_to users_purchases_path, notice: '商品を購入しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def purchase_params
      params.require(:purchase).permit(%i[delivery_fee handling_fee delivery_on delivery_time address_id])
    end
end
