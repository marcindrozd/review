class AddAuthoredAtToCommit < ActiveRecord::Migration
  def change
    add_column :commits, :authored_at, :datetime
  end
end
