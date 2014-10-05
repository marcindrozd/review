class TicketsController < ApplicationController
  include Support::FakeSlowResponse

  expose(:ticket)

  respond_to :json

  def show
    respond_with(ticket)
  end
end
