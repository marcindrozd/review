class Api::V1::BaseController < ApplicationController
  respond_to :json
private
  def auth_token
    render json: { message: t('.no_access') } unless token && Project.from_token(token).exists?
  end

  def token
    params[:token]
  end
end
