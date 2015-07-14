class Api::V1::TradeController < Api::V1::BaseController
  before_filter :auth_token

  expose(:user) { Token.get_tokenable(token) }
  expose(:projects) { Project.all }

  def index
    render json: projects, each_serializer: Api::V1::NewTradeSerializer, root: false
  end

  private

  def auth_token
    deny_access unless token && user.present? && user.instance_of?(User)
  end

  def token
    params[:token]
  end
end
