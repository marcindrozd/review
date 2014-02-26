class AddUrlToProject < ActiveRecord::Migration
  def up
    add_column :projects, :url, :string, unique: true, default: '', null: false
  end

  def down
    remove_column :projects, :url
  end
end
