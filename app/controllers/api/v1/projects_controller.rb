class Api::V1::ProjectsController < Api::V1::BaseController
  before_filter :auth_token
  expose(:project)

  def show
    render json: project, serializer: Api::V1::ProjectSerializer
  end

  private
  def auth_token
    render json: { message: t('.no_access') }, status: 401 unless token && Project.from_token(token).exists?
  end

  def token
    params[:token]
  end
end
