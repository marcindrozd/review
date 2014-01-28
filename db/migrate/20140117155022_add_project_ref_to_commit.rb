class AddProjectRefToCommit < ActiveRecord::Migration
  def change
    add_reference :commits, :project, index: true
  end
end
