class AddTokenToProject < ActiveRecord::Migration
  def up
    add_column :projects, :token, :string, unique: true, default: '', null: false
    add_index :projects, :token
  end

  def down
    remove_column :projects, :token
    remove_index :projects, :token
  end
end
