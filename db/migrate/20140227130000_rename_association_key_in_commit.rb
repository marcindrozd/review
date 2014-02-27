class RenameAssociationKeyInCommit < ActiveRecord::Migration
  def change
    rename_column :commits, :commit_user_id, :author_id
  end
end
