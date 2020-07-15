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
         :recoverable, :rememberable, :validatable, :confirmable

  enum category: {
    カスタマー: 0,
    配達員: 1,
    # 両方: 2
  }

  has_many :orders

  validates :category, acceptance: true
  validates :family_name, presence: true, length: { in: 1..20 }
  validates :first_name, presence: true, length: { in: 1..20 }
  validates :postal_code, presence: true, length: { in: 1..255 }
  validates :address, presence: true, length: { in: 1..255 }
  validates :phone_number, presence: true, length: { in: 1..13 }
end
