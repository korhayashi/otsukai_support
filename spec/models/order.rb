require 'rails_helper'
RSpec.describe '依頼登録機能', type: :model do
  it 'contentが空ならバリデーションが通らない' do
    order = Order.new(
      content: '',
      status: 0,
      deadline: DateTime.now + 1,
      customer_id: '1',
    )
    expect(order).not_to be_valid
  end

  it 'deadlineが現在の日時より前からバリデーションが通らない' do
    order = Order.new(
      content: 'content',
      status: 0,
      deadline: DateTime.now - 1,
      customer_id: '1',
    )
    expect(order).not_to be_valid
  end
end
