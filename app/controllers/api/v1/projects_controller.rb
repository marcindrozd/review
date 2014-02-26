class Api::V1::ProjectsController < Api::V1::BaseController
  before_filter :auth_token
  expose(:project)

  def show
    respond_with(project)
  end
end
