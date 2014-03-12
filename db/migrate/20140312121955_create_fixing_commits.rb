class CreateFixingCommits < ActiveRecord::Migration
  def change
    create_table :fixing_commits do |t|
      t.integer :fixing_commit_id, null: false
      t.integer :fixed_commit_id,  null: false
      t.timestamps
    end

    add_index :fixing_commits, :fixed_commit_id
    add_index :fixing_commits, :fixing_commit_id
    add_index :fixing_commits, [:fixing_commit_id, :fixed_commit_id], unique: true
  end
end
