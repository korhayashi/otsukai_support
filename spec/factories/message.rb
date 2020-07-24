FactoryBot.define do
  factory :message1, class: Message do
    id { 1 }
    body { 'test' }
    conversation_id { 1 }
    user_id { 2 }
  end

  factory :message2, class: Message do
    id { 2 }
    body { 'test2' }
    conversation_id { 2 }
    user_id { 4 }
  end
end
