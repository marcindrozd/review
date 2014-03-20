class CreateProjectOwners < ActiveRecord::Migration
  def change
    create_table :project_owners do |t|
      t.string :name, null: false
      t.string :email
      t.timestamps
    end
  end
end
