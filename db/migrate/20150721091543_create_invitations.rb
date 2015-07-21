class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :email
      t.string :token
      t.string :role
      t.string :project_ids
      t.integer :sender_id
      t.integer :recipient_id

      t.timestamps
    end
  end
end
