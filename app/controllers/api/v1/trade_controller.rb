class Api::V1::TradeController < Api::V1::BaseController
  expose(:projects){ Commit.unreviewed.includes(:project).map(&:project).uniq }
  def index
    render json: projects, each_serializer: Api::V1::TradeSerializer, root: 'projects'
  end

end
