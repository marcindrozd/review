class CreateCommit < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.string :remote_id
      t.string :message
      t.string :url
      t.string :state
    end
  end
end
