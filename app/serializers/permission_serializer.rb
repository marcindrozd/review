class PermissionSerializer < ApplicationSerializer
  attributes :id, :user_id, :project_id, :allowed
end
