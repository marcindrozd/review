class CreateCommitTickets < ActiveRecord::Migration
  def change
    create_table :commits_tickets, :id => false do |t|
      t.integer :commit_id
      t.integer :ticket_id
    end
    add_index :commits_tickets, [:commit_id, :ticket_id]
  end
end
