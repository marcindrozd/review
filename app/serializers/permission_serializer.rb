class PermissionSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :project_id, :allowed
end
