FactoryBot.define do
  factory :order1, class: Order do
    id { 1 }
    content { 'test' }
    note { '' }
    status { '依頼中' }
    deadline { DateTime.now + 1 }
    customer_id { 3 }
    created_at { DateTime.now - 1 }
  end

  factory :order2, class: Order do
    id { 2 }
    content { 'test2' }
    note { '' }
    status { '配達員決定' }
    deadline { DateTime.now + 1 }
    customer_id { 1 }
    courier_id { 4 }
  end

  factory :order3, class: Order do
    id { 3 }
    content { 'test3' }
    note { '' }
    status { '依頼中' }
    deadline { DateTime.now + 2 }
    customer_id { 1 }
  end

  factory :order4, class: Order do
    id { 4 }
    content { 'test4' }
    note { '' }
    status { '配達員決定' }
    deadline { DateTime.now + 1 }
    customer_id { 1 }
    courier_id { 2 }
  end
end
