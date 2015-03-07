class AddStateTypes < ActiveRecord::Migration
  def change
    create_table :state_types do |t|
      t.string :name, null: false, limit: 255, uniq: true
      t.boolean :blocking, default: false
    end
  end
end
