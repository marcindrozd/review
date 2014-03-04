class AddExpiresAtToCommit < ActiveRecord::Migration
  def change
    add_column :commits, :expires_at, :datetime
  end
end
