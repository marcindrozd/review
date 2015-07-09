class Api::V2::UsersController < Api::V2::BaseController
  before_filter :change_admin_flag, only: :update

  expose(:user) { find_user }
  expose(:users)
  expose(:paginated_users) { users.order(nickname: :asc).page params[:page] }

  def index
    respond_with paginated_users, meta: { total_pages: user_pages_count }
  end

  def show
    respond_with(user)
  end

  def update
    user.update_attributes(user_params)
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
    render json: { message: "You are not authorized to do it." }, status: 401 unless current_user.has_role? :admin
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :email)
  end

  def user_pages_count
    (users.count / paginated_users.default_per_page.to_f).ceil
  end
end
