class CreatePermission < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :project_id
      t.integer :user_id
      t.boolean :allowed, default: false
    end
    add_index :permissions, :project_id
    add_index :permissions, :user_id
    add_index :permissions, [:project_id, :user_id], unique: true
  end
end
