class Api::V2::RolesController < Api::V2::BaseController
  expose(:roles)

  def index
    respond_with roles
  end
end
