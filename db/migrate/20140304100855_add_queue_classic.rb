class AddQueueClassic < ActiveRecord::Migration
  def change
    create_table "queue_classic_jobs", force: true do |t|
      t.text     "q_name",    null: false
      t.text     "method",    null: false
      t.json     "args",      null: false
      t.datetime "locked_at"
    end

    add_index "queue_classic_jobs", [:q_name, :id]
  end
end
