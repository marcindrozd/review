class Api::V1::TradeController < Api::V1::BaseController
  before_filter :auth_token

  expose(:user) { Token.get_tokenable(token) }
  expose(:projects) { Project.for_user(user) }

  def index
    render json: projects, each_serializer: Api::V1::TradeSerializer, root: 'projects'
  end

  private
  def auth_token
    deny_access unless token && user.present? && user.instance_of?(User)
  end

  def deny_access
    render json: { message: t('api.v1.no_access') }, status: 401
  end

  def token
    params[:token]
  end
end
