class AddIndexToConversations < ActiveRecord::Migration[5.2]
  def change
    add_reference :conversations, :order, foreign_key: true

    add_index :conversations, :sender_id
    add_index :conversations, :recipient_id
    add_index :conversations, [:sender_id, :recipient_id], unique: true
  end
end
