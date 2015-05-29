class Api::V2::TicketsController < Api::V2::BaseController
  expose(:ticket)

  def show
    respond_with(ticket)
  end
end
