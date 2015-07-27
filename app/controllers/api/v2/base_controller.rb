class Api::V2::BaseController < ApplicationController
  respond_to :json

  private

  def check_permission
    render json: { message: "You are not authorized to do it." },
      status: 401 unless current_user.has_role? :admin
  end
end
