class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :email
      t.string :name
      t.string :image_url
      t.string :remote_uid
      t.string :provider
    end
  end
end
