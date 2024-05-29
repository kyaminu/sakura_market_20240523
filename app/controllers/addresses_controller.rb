class AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_address, only: %i[edit show create update destroy]

  def index
    @addresses = current_user.addresses.default_order
  end

  def new
    @addresse = current_user.addresses.new
  end

  def edit
  end

  def create
    @addresse = current_user.addresses.new(address_params)
    if @addresse.save
      redirect_to addresses_path, notice: '登録しました'
    else
      render :new
    end
  end

  def update
    if @addresse.update(address_params)
      redirect_to addresses_path, notice: '更新しました'
    else
      render :edit
    end
  end

  def destroy
    @addresse.destroy!
    redirect_to
  end

  private

    def set_address
      @addresse = Address.find(params[:id])
    end

    def address_params
      params.require(:address).permit(%i[name_kanji name_kana phone_number postal_code prefecture city street])
    end
end
