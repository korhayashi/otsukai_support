FactoryBot.define do
  factory :order1, class: Order do
    id { 1 }
    content { 'test' }
    status { 0 }
    deadline { DateTime.now + 1 }
    customer_id { 3 }
  end

  factory :order2, class: Order do
    id { 2 }
    content { 'test2' }
    status { 1 }
    deadline { DateTime.now + 1 }
    customer_id { 1 }
    courier_id { 4 }
  end

  factory :order3, class: Order do
    id { 3 }
    content { 'test3' }
    status { 0 }
    deadline { DateTime.now - 1 }
    customer_id { 1 }
  end

  factory :order4, class: Order do
    id { 4 }
    content { 'test4' }
    status { 0 }
    deadline { DateTime.now + 1 }
    customer_id { 1 }
  end

  factory :order5, class: Order do
    id { 5 }
    content { 'test5' }
    status { 1 }
    deadline { DateTime.now + 1 }
    customer_id { 1 }
    courier_id { 2 }
  end
end
