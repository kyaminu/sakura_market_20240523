class Users::PurchasesController < Users::ApplicationController
  def new
    @purchase = current_user.purchases.new
  end

  def create
    @purchase = current_user.purchases.new(purchase_params)
    if @purchase.save
      # TODO: まだ履歴画面作ってないので一旦ここに返す
      redirect_to root_path, notice: '商品を購入しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def purchase_params
      params.require(:purchase).permit(%i[delivery_fee handling_fee delivery_on delivery_time name phone_number postal_code address])
    end
end
