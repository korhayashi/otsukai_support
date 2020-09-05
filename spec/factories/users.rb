# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  address                :string           not null
#  admin                  :boolean          default(FALSE), not null
#  category               :integer          not null
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  family_name            :string           not null
#  first_name             :string           not null
#  image                  :string
#  phone_number           :string           not null
#  postal_code            :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
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
