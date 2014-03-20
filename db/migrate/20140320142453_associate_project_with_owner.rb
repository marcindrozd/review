class AssociateProjectWithOwner < ActiveRecord::Migration
  def change
    remove_column :projects, :owner_name, :string
    add_column :projects, :project_owner_id, :integer
  end
end
