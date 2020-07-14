class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.text :content, null: false
      t.text :note
      t.integer :status, null: false
      t.datetime :deadline, null: false
      t.integer :customer_id, index: true, null: false
      t.integer :courier_id, index: true
    end
    add_foreign_key :orders, :users, column: :customer_id
    add_foreign_key :orders, :users, column: :courier_id
  end
end
