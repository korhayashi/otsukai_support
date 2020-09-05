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
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum category: {
    カスタマー: 0,
    配達員: 1,
  }

  has_many :orders

  validates :family_name, presence: true, length: { in: 1..20 }
  validates :first_name, presence: true, length: { in: 1..20 }
  validates :postal_code, presence: true, length: { in: 1..255 }
  validates :address, presence: true, length: { in: 1..255 }
  validates :phone_number, presence: true, length: { in: 1..13 }

  def self.customer
    find_or_create_by(email: 'test@test.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.category = 'カスタマー'
      user.family_name = 'カスタマー'
      user.first_name = 'テスト'
      user.postal_code = '123-4567'
      user.address = 'テスト県テスト市'
      user.phone_number = '090-1234-5678'
    end
  end

  def self.courier
    find_or_create_by(email: 'test2@test.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.category = '配達員'
      user.family_name = '配達員'
      user.first_name = 'テスト'
      user.postal_code = '123-4567'
      user.address = 'テスト県テスト市'
      user.phone_number = '090-1234-5678'
    end
  end
end
