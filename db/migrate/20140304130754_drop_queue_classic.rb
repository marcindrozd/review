class DropQueueClassic < ActiveRecord::Migration
  def change
    QC::Setup.drop
  end
end
