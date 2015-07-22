class InvitationSerializer < ApplicationSerializer
  attributes :id, :email, :role, :project_ids, :date, :status

  def status
    object.accepted ? 'accepted' : 'pending'
  end

  def date
    object.created_at.strftime("%d %b. %Y")
  end
end
