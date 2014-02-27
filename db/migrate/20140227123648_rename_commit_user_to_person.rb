class RenameCommitUserToPerson < ActiveRecord::Migration
  def change
    rename_table :commit_users, :people
  end
end
