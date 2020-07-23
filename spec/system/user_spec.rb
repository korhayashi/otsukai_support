require 'rails_helper'
RSpec.describe 'ユーザー登録・ログイン・ログアウト機能', type: :system do
  describe 'ユーザー登録のテスト' do
    context 'ユーザーのデータがなくログインしていない状態' do
      it 'カスタマーユーザー新規登録のテスト' do
        visit new_user_registration_path
        fill_in 'user[family_name]', with: 'サンプル'
        fill_in 'user[first_name]', with: '花子'
        fill_in 'Eメール', with: 'customer@sample.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード（確認用）', with: 'password'
        fill_in '郵便番号', with: '123-4567'
        fill_in '住所', with: 'サンプル県サンプル市'
        fill_in '電話番号', with: '03-1234-5678'
        choose 'カスタマー'
        click_button 'アカウント登録'

        visit letter_opener_web_path

        click_on 'メールアドレスの確認'
        click_link 'ログイン'

        fill_in 'Eメール', with: 'customer@sample.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'

        expect(page).to have_content 'ログインしました。'
      end
      # it 'ログインしていない時はログイン画面に飛ぶテスト' do
      #   visit root_path
      #   expect(current_path).to eq new_session_path
      # end
    end
  end
end
