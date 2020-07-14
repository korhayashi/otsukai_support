class AddColumnCompletedTimeToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :completed_date, :datetime
  end
end
