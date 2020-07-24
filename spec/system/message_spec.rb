require 'rails_helper'
RSpec.describe "メッセージ機能", type: :system do
  def customer_login
    visit new_user_session_path
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

  before do
    @customer_user = FactoryBot.create(:customer_user)
    @courier_user = FactoryBot.create(:courier_user)
    @order5 = FactoryBot.create(:order5)
    @conversation3 = FactoryBot.cream(:conversation3)
  end

  describe "配達員が受託している依頼があること" do
    before do
      customer_login
    end

    context "メッセージを送信した場合" do
      it "チャットルームに新規メッセージが投稿され、相手が見ると既読がつくこと" do
        click_link '配達員に連絡'
        fill_in 'message_body', with: 'sample'
        click_button '隠しボタン'
        expect(page).to have_content 'sample'
        click_link 'ログアウト'

        courier_login
        click_link 'カスタマーに連絡'
        sleep 1
        click_link 'ログアウト'

        customer_login
        click_link '配達員に連絡'
        expect(page).to have_content '既読'
      end
    end
  end


end
