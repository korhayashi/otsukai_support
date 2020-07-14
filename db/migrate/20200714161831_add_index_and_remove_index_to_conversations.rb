class AddIndexAndRemoveIndexToConversations < ActiveRecord::Migration[5.2]
  def change
    remove_index :conversations, :order_id
    remove_index :conversations, :recipient_id
    remove_index :conversations, :sender_id
    remove_index :conversations, [:sender_id, :recipient_id]

    add_index :conversations, :order_id, unique: true
  end
end
