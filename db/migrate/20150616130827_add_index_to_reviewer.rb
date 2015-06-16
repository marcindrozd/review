class AddIndexToReviewer < ActiveRecord::Migration
  def change
    add_index :commits, :reviewer_id
  end
end
