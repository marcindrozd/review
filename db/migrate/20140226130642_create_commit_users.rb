class CreateCommitUsers < ActiveRecord::Migration
  def change
    create_table :commit_users do |t|
      t.string :username
      t.string :email
      t.string :name
      t.timestamps
    end
  end
end
