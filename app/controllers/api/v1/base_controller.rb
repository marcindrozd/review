class Api::V1::BaseController < ApplicationController
  skip_before_filter :authentication_check
  respond_to :json
private
  def auth_token
    render json: { message: t('.no_access') }, status: 401 unless token && Project.from_token(token).exists?
  end

  def token
    params[:token]
  end
end
