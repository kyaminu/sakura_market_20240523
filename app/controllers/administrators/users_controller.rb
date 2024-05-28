class Administrators::UsersController < Administrators::ApplicationController
  before_action :set_user, only: %i[edit update]

  def index
    @users = User.default_order
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to administrators_users_path, notice: '更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(%i[name email])
    end
end
