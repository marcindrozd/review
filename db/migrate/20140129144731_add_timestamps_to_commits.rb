class AddTimestampsToCommits < ActiveRecord::Migration
  def change
    add_column :commits, :created_at, :datetime
    add_column :commits, :passed_at, :datetime
  end
end
