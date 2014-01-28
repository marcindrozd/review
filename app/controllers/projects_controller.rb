class ProjectsController < ApplicationController

  include Support::FakeSlowResponse

  expose(:project)
  expose(:projects) { find_projects }

  respond_to :json

  def index
    respond_with(projects)
  end

  def show
    respond_with(project)
  end

  private

  def find_projects
    if current_user.admin?
      Project.all
    else
      Project.joins(:permissions).where(permissions: {user_id: current_user.id, allowed: true})
    end
  end
end
