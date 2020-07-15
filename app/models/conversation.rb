# == Schema Information
#
# Table name: conversations
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  order_id     :bigint
#  recipient_id :integer
#  sender_id    :integer
#
# Indexes
#
#  index_conversations_on_order_id  (order_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
class Conversation < ApplicationRecord
  belongs_to :order
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'
  has_many :messages, dependent: :destroy

  # def target_user(current_user)
  #   if sender_id == current_user.id
  #     User.find(recipient_id)
  #   elsif recipient_id == current_user.id
  #     User.find(sender_id)
  #   end
  # end
end
