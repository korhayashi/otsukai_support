class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :category, :integer, null: false
    add_column :users, :family_name, :string, null: false
    add_column :users, :first_name, :string, null: false
    add_column :users, :postal_code, :integer, null: false
    add_column :users, :address, :string, null: false
    add_column :users, :phone_number, :integer, null: false
    add_column :users, :admin, :boolean, null: false, default: false
  end
end
