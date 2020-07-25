require 'rails_helper'
RSpec.describe "メッセージ機能", type: :system do
  def user_confirmation
    @user = User.last
    @token = @user.confirmation_token
    visit user_confirmation_path(confirmation_token: @token)
  end

  def customer_login
    visit new_user_session_path
    fill_in 'Eメール', with: 'customer@sample.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  def courier_login
    visit new_user_session_path
    fill_in 'Eメール', with: 'courier@sample.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  def logout
    click_link 'ログアウト'
    expect {
    page.accept_confirm do
      expect(current_path).to eq root_path
    end
    }
  end

  before do
    @customer_user = FactoryBot.create(:customer_user)
    user_confirmation
    @courier_user = FactoryBot.create(:courier_user)
    user_confirmation
    @order4 = FactoryBot.create(:order4)
  end

  describe "配達員が受託している依頼があること" do
    before do
      customer_login
    end

    context "メッセージを送信した場合" do
      it "チャットルームに新規メッセージが投稿され、相手が見ると既読がつくこと" do
        click_link '配達員に連絡'
        sleep 2
        fill_in 'message_body', with: 'sample'
        sleep 1
        click_button '隠しボタン'
        sleep 1
        expect(page).to have_content 'sample'
        logout

        courier_login
        sleep 1
        click_link 'カスタマーに連絡'
        sleep 2
        logout

        customer_login
        click_link '配達員に連絡'
        sleep 2
        expect(page).to have_content '既読'
      end
    end
  end


end
