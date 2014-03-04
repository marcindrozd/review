class DropQueueClassic < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.down do
        add_index "queue_classic_jobs", [:q_name, :id]
      end
    end
    drop_table "queue_classic_jobs", force: true do |t|
      t.text     "q_name",    null: false
      t.text     "method",    null: false
      t.json     "args",      null: false
      t.datetime "locked_at"
    end
  end
end
