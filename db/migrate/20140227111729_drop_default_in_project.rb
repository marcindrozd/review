class DropDefaultInProject < ActiveRecord::Migration
  def change
    change_column :projects, :token, :string, null: false, unique: true
    change_column :projects, :url,   :string, null: false, unique: true
  end
end
