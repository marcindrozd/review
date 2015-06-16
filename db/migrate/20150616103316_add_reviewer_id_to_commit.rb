class AddReviewerIdToCommit < ActiveRecord::Migration
  def change
    add_column :commits, :reviewer_id, :integer
  end
end
