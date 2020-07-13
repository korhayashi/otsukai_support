class AddColumnTimestampsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :created_at, :datetime, null: true
    add_column :orders, :updated_at, :datetime, null: true

    Order.update_all(created_at: DateTime.now)
    Order.update_all(updated_at: DateTime.now)

    change_column :orders, :created_at, :datetime, null: false
    change_column :orders, :updated_at, :datetime, null: false
  end
end
