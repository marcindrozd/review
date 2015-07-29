class AddProjectIdsToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :project_ids, :text, array: true, default: []
  end
end
