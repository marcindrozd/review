class CreateToken < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string  :value, unique: true
      t.string  :tokenable_type
      t.integer :tokenable_id
    end

    add_index(:tokens, :value, unique: true)
    add_index(:tokens, [:tokenable_id, :tokenable_type], unique: true)
  end
end
