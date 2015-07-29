class RemoveProjectIdsFromInvitations < ActiveRecord::Migration
  def change
    remove_column :invitations, :project_ids, :string
  end
end
