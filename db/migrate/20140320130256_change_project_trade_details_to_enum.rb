class ChangeProjectTradeDetailsToEnum < ActiveRecord::Migration
  def up
    remove_column :projects, :trade_details
    add_column :projects, :trade_details, :integer, default: 0, null: false
  end

  def down
    remove_column :projects, :trade_details
    add_column :projects, :trade_details, :string
  end
end
