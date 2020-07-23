require 'rails_helper'
RSpec.describe 'ユーザー登録機能', type: :model do
  it 'emailが空ならバリデーションが通らない' do
    user = User.new(
      email: '',
      password: 'password',
      category: 0,
      family_name: 'サンプル',
      first_name: '花子',
      postal_code: '123-4567',
      address: 'サンプル県サンプル市',
      phone_number: '03-1234-5678'
    )
    expect(user).not_to be_valid
  end

  it 'passwordが空ならバリデーションが通らない' do
    user = User.new(
      email: 'customer@sample.com',
      password: '',
      category: 0,
      family_name: 'サンプル',
      first_name: '花子',
      postal_code: '123-4567',
      address: 'サンプル県サンプル市',
      phone_number: '03-1234-5678'
    )
    expect(user).not_to be_valid
  end

  it 'family_nameが空ならバリデーションが通らない' do
    user = User.new(
      email: 'customer@sample.com',
      password: 'password',
      category: 0,
      family_name: '',
      first_name: '花子',
      postal_code: '123-4567',
      address: 'サンプル県サンプル市',
      phone_number: '03-1234-5678'
    )
    expect(user).not_to be_valid
  end

  it 'first_nameが空ならバリデーションが通らない' do
    user = User.new(
      email: 'customer@sample.com',
      password: 'password',
      category: 0,
      family_name: 'サンプル',
      first_name: '',
      postal_code: '123-4567',
      address: 'サンプル県サンプル市',
      phone_number: '03-1234-5678'
    )
    expect(user).not_to be_valid
  end

  it 'postal_codeが空ならバリデーションが通らない' do
    user = User.new(
      email: 'customer@sample.com',
      password: 'password',
      category: 0,
      family_name: 'サンプル',
      first_name: '花子',
      postal_code: '',
      address: 'サンプル県サンプル市',
      phone_number: '03-1234-5678'
    )
    expect(user).not_to be_valid
  end

  it 'addressが空ならバリデーションが通らない' do
    user = User.new(
      email: 'customer@sample.com',
      password: 'password',
      category: 0,
      family_name: 'サンプル',
      first_name: '花子',
      postal_code: '123-4567',
      address: '',
      phone_number: '03-1234-5678'
    )
    expect(user).not_to be_valid
  end

  it 'phone_numberが空ならバリデーションが通らない' do
    user = User.new(
      email: 'customer@sample.com',
      password: 'password',
      category: 0,
      family_name: 'サンプル',
      first_name: '',
      postal_code: '123-4567',
      address: 'サンプル県サンプル市',
      phone_number: ''
    )
    expect(user).not_to be_valid
  end
end
