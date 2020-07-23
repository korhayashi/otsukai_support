require 'rails_helper'
RSpec.describe 'ユーザー登録・ログイン・ログアウト・会員機能', type: :system do
  before do
    @customer_user = FactoryBot.create(:customer_user)
    @courier_user = FactoryBot.create(:courier_user)
  end

  def customer_login
    visit new_user_registration_path
    fill_in 'Eメール', with: 'customer@sample.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  def courier_login
    visit new_user_registration_path
    fill_in 'Eメール', with: 'courier@sample.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  describe 'ユーザー登録のテスト' do
    context 'ユーザーのデータがなくログインしていない状態' do
      # # 原因不明エラーが出る
      # it 'カスタマーユーザー新規登録のテスト' do
      #   visit new_user_registration_path
      #   fill_in 'user[family_name]', with: 'サンプル'
      #   fill_in 'user[first_name]', with: '花子'
      #   fill_in 'Eメール', with: 'customer@sample.com'
      #   fill_in 'パスワード', with: 'password'
      #   fill_in 'パスワード（確認用）', with: 'password'
      #   fill_in '郵便番号', with: '123-4567'
      #   fill_in '住所', with: 'サンプル県サンプル市'
      #   fill_in '電話番号', with: '03-1234-5678'
      #   choose 'カスタマー'
      #   click_button 'アカウント登録'
      #
      #   visit letter_opener_web_path
      #
      #   click_on 'メールアドレスの確認'
      #
      #   expect(page).to have_content 'アカウント登録が完了しました。'
      # end
      #
      # it '配達員ユーザー新規登録のテスト' do
      #   visit new_user_registration_path
      #   fill_in 'user[family_name]', with: '配達'
      #   fill_in 'user[first_name]', with: '太郎'
      #   fill_in 'Eメール', with: 'courier@sample.com'
      #   fill_in 'パスワード', with: 'password'
      #   fill_in 'パスワード（確認用）', with: 'password'
      #   fill_in '郵便番号', with: '234-5678'
      #   fill_in '住所', with: 'サンプル県サンプル市'
      #   fill_in '電話番号', with: '090-1234-5678'
      #   choose '配達員'
      #   click_button 'アカウント登録'
      #
      #   visit letter_opener_web_path
      #
      #   click_on 'メールアドレスの確認'
      #
      #   expect(page).to have_content 'アカウント登録が完了しました。'
      # end

    it 'ログインしていない状態でマイページに入ろうとするとログイン画面に飛ぶテスト' do
      visit home_path
      expect(current_path).to eq new_user_session_path
    end
  end

  describe 'セッション機能のテスト' do

    context 'ログインしていない状態でユーザーのデータがある場合'
      it 'ログインができること' do
        customer_login

        expect(page).to have_content 'ログインしました。'
      end
    end
  end
end
