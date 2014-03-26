class Api::V1::BaseController < ActionController::Base
  respond_to :json

  private

  def deny_access
    render json: { message: t('api.v1.no_access') }, status: 401
  end
end
