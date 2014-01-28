class CreateTicket < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :remote_id
      t.string :url
      t.string :source
    end
  end
end
