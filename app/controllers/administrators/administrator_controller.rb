class Administrators::AdministratorController < Administrators::ApplicationController
before_action :set_administrator, only: %i[edit update destroy]

  def index
    @administrators = Administrator.default_order
  end

  def new
    @administrator = Administrator.new
  end

  def edit
  end

  def create
    @administrator = Administrator.new(administrator_params)
    if @administrator.save
      redirect_to administrators_administrator_index_path, notice: '作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @administrator.update
      redirect_to administrators_administrator_index_path, notice: '更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @administrator.destroy!
    redirect_to administrators_administrator_index_path, notice: '削除しました', status: :see_other
  end

  private

    def set_admin_user
      @administrator = Administrator.find(params[:id])
    end

    def administrator_params
      params.require(:administrator).permit(%i[email password])
    end
end
