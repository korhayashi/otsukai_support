FactoryBot.define do
  factory :conversation1, class: Conversation do
    id { 1 }
    sender_id { 2 }
    recipient_id { 3 }
    order_id { 1 }
  end

  factory :conversation2, class: Conversation do
    id { 2 }
    sender_id { 4 }
    recipient_id { 1 }
    order_id { 2 }
  end

  factory :conversation3, class: Conversation do
    id { 3 }
    sender_id { 1 }
    recipient_id { 2 }
    order_id { 5 }
  end
end
