class Api::V2::UsersController < Api::V2::BaseController
  before_filter :update_user, only: :update

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
    update_roles
    respond_with(user)
  end

  private

  def find_user
    for_current_user? ? current_user : User.friendly.find(params[:id])
  end

  def for_current_user?
    params[:id] == 'me'
  end

  private

  def update_roles
    role = params['user']['role']
    projectIds = params['user']['project_ids']
    return unless role
    remove_user_roles
    add_user_roles(role, projectIds)
  end

  def add_user_roles(role, projectIds)
    projectIds ? projectIds.each { |id| user.add_role role, Project.find(id) } : user.add_role(role)
  end

  def remove_user_roles
    user.roles.each do |role|
      user.remove_role role.name
    end
  end

  def update_user
    render json: { message: "You are not authorized to do it." }, status: 401 unless current_user.has_role? :admin
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :email)
  end

  def user_pages_count
    (users.count / paginated_users.default_per_page.to_f).ceil
  end
end
