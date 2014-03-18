class AddOwnerAndTradeTypeToProject < ActiveRecord::Migration
  def change
    add_column :projects, :owner_name, :string
    add_column :projects, :trade_details, :string
  end
end
