class Administrators::ItemsController < Administrators::ApplicationController
  before_action :set_item, only: %i[edit update destroy move_higher move_lower]

  def index
    @items = Item.default_order
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to administrators_root_path, notice: t('controller.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @item.update(item_params)
      redirect_to administrators_root_path, notice: t('controller.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy!
    redirect_to administrators_items_path, notice: t('controller.destroyed'), status: :see_other
  end

  def move_higher
    @item.move_higher
    redirect_to administrators_items_path, notice: t('controller.moved')
  end

  def move_lower
    @item.move_lower
    redirect_to administrators_items_path, notice: t('controller.moved')
  end

  private

    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(%i[name description price_excluding_tax published image])
    end
end
