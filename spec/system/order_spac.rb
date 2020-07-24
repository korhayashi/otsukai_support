require 'rails_helper'
RSpec.describe "買い物依頼機能", type: :system do
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
  end

  describe "カスタマーユーザーでログインしている場合" do
    before do
      customer_login
    end

    context "新規依頼を作成した場合" do
      @now = DateTime.now

      it "新規依頼が登録されマイページに表示される" do
        visit new_order_path
        fill_in 'order_content', with: 'sample'
        select @now.mon + 1, from: 'order_deadline_2i'
        click_button '依頼する'
        click_button '依頼確定'
        expect(page).to have_content '現在配達員を探しています。'
      end
    end
  end

  describe "配達員ユーザーでログインしている場合" do
    before do
      courier_login
    end

    context "依頼一覧画面から依頼を選んで受託する" do
      it "依頼に配達員がアサインされマイページに表示される" do
        @order4 = FactoryBot.create(:order4)
        visit orders_path
        click_link '依頼詳細'
        click_button '依頼受託'
        expect(page).to have_content '受託中の依頼'
      end
    end

    context "受託している依頼の配達完了を申請する" do
      it "配達完了ステータスが登録されマイページから受託依頼がなくなる" do
        @order5 = FactoryBot.create(:order5)
        click_link '依頼詳細'
        click_button '配達完了'
        expect(page).not_to have_content '受託中の依頼'
      end
    end
  end
end
