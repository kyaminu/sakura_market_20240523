class Users::AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_address, only: %i[edit update destroy]

  def index
    @addresses = current_user.addresses.default_order
  end

  def new
    @address = current_user.addresses.new
  end

  def edit
  end

  def create
    @address = current_user.addresses.new(address_params)
    if @address.save
      redirect_to users_addresses_path, notice: '登録しました'
    else
      render :new
    end
  end

  def update
    if @address.update(address_params)
      redirect_to users_addresses_path, notice: '更新しました'
    else
      render :edit
    end
  end

  def destroy
    @address.destroy!
    redirect_to users_addresses_path
  end

  private

    def set_address
      @address = Address.find(params[:id])
    end

    def address_params
      params.require(:address).permit(%i[name_kanji name_kana phone_number postal_code prefecture_code city street])
    end
end
