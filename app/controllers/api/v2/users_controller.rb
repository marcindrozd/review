class Api::V2::UsersController < Api::V2::BaseController
  before_filter :change_admin_flag, only: :update

  expose(:user) { find_user }
  expose(:users)

  def index
    respond_with(users)
  end

  def show
    respond_with(user)
  end

  def update
    user.update_attributes(admin_parameters)
    respond_with(user)
  end

  private

  def find_user
    for_current_user? ? current_user : User.find(params[:id])
  end

  def for_current_user?
    params[:id] == 'me'
  end

  private

  def change_admin_flag
    render json: { message: "You are not authorized to do it." }, status: 401 unless current_user.admin?
  end

  def admin_parameters
    params.require(:user).permit(:admin)
  end
end
