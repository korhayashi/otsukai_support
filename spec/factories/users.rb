FactoryBot.define do
  factory :customer_user, class: User do
    id { 1 }
    email { 'customer@sample.com' }
    password { 'password' }
    category { 'カスタマー' }
    family_name { 'サンプル' }
    first_name { '花子' }
    postal_code { '123-4567' }
    address { 'サンプル県サンプル市' }
    phone_number { '03-1234-5678' }
  end

  factory :courier_user, class: User do
    id { 2 }
    email { 'courier@sample.com' }
    password { 'password' }
    category { '配達員' }
    family_name { '配達' }
    first_name { '太郎' }
    postal_code { '234-5678' }
    address { 'サンプル県サンプル市' }
    phone_number { '090-1234-5678' }
  end

  factory :customer_user2, class: User do
    id { 3 }
    email { 'customer2@sample.com' }
    password { 'password' }
    category { 'カスタマー' }
    family_name { 'テスト' }
    first_name { '雅子' }
    postal_code { '123-4567' }
    address { 'サンプル県サンプル市' }
    phone_number { '03-1234-5678' }
  end

  factory :courier_user2, class: User do
    id { 4 }
    email { 'courier2@sample.com' }
    password { 'password' }
    category { '配達員' }
    family_name { 'デリバー' }
    first_name { '次郎' }
    postal_code { '234-5678' }
    address { 'サンプル県サンプル市' }
    phone_number { '090-1234-5678' }
  end
end
