class Api::V1::ProjectsController < Api::V1::BaseController
  before_filter :auth_token
  expose(:project) { Project.from_token(token).first }

  def index
    render json: project, serializer: Api::V1::ProjectSerializer
  end

  private
  def auth_token
    render json: { message: t('.no_access') }, status: 401 unless token && project.present?
  end

  def token
    params[:token]
  end
end
