# == Schema Information
#
# Table name: orders
#
#  id             :bigint           not null, primary key
#  completed_date :datetime
#  content        :text             not null
#  deadline       :datetime         not null
#  note           :text
#  status         :integer          default("依頼中"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  courier_id     :integer
#  customer_id    :integer          not null
#
# Indexes
#
#  index_orders_on_courier_id   (courier_id)
#  index_orders_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  fk_rails_...  (courier_id => users.id)
#  fk_rails_...  (customer_id => users.id)
#
class Order < ApplicationRecord
  belongs_to :user, optional: true

  enum status: {
    依頼中: 0,
    配達員決定: 1,
    配達完了: 2
  }
end
