class InvitationSerializer < ApplicationSerializer
  attributes :id, :email, :role, :project_ids
end
