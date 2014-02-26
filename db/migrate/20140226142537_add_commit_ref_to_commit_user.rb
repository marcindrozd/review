class AddCommitRefToCommitUser < ActiveRecord::Migration
  def change
    add_reference :commits, :commit_user, index: true
  end
end
