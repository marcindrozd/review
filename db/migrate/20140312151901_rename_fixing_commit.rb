class RenameFixingCommit < ActiveRecord::Migration
  def up
    rename_table :fixing_commits, :commit_fixes
  end

 def down
    rename_table :commit_fixes, :fixing_commits
 end
end
