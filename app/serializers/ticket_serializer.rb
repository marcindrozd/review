class TicketSerializer < ApplicationSerializer
  attributes :id, :remote_id, :remote_url, :color

  def remote_url
    object.url
  end

  def color
    StringColorizer.new(remote_id).hexcolor
  end
end
