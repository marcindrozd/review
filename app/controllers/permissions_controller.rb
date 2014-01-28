class PermissionsController < ApplicationController

  include Support::FakeSlowResponse

  expose(:permission, attributes: :permission_params)
  expose(:permissions) { Permission.all }

  respond_to :json

  def index
    respond_with(permissions)
  end

  def show
    respond_with(permission)
  end

  def create
    permission.save
    respond_with(permission)
  end

  def update
    permission.save
    respond_with(permission)
  end

  private

  def permission_params
    params.require(:permission).permit(:user_id, :project_id, :allowed)
  end

end
