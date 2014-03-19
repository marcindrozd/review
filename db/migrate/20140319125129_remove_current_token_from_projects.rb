class RemoveCurrentTokenFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :token
  end
end
