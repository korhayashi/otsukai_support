class AddDefaultStatusToOrders < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :status, :integer, null: false, default: 0
  end
end
