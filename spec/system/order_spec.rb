require 'rails_helper'
RSpec.describe "買い物依頼機能", type: :system do
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

  before do
    @customer_user = FactoryBot.create(:customer_user)
    user_confirmation
    @courier_user = FactoryBot.create(:courier_user)
    user_confirmation
  end

  describe "カスタマーユーザーでログインしている場合" do
    before do
      customer_login
    end

    context "新規依頼を作成した場合" do
      it "新規依頼が登録されマイページに表示される" do
        now = DateTime.now
        sleep 1
        click_link '新規買い物依頼'
        fill_in 'order_content', with: 'sample'
        select now.mon + 1, from: 'order_deadline_2i'
        click_button '依頼する'
        sleep 1
        click_button '依頼確定'
        expect(page).to have_content '現在配達員を探しています。'
      end
    end
  end

  describe "配達員ユーザーでログインしている場合" do
    before do
      @customer_user2 = FactoryBot.create(:customer_user2)
      user_confirmation
      @order1 = FactoryBot.create(:order1)
      @order3 = FactoryBot.create(:order3)
      @order4 = FactoryBot.create(:order4)
      courier_login
    end

    context '複数の依頼がある場合' do
      it '依頼が作成日時の降順に並んでいる' do
        click_link '依頼一覧'
        sleep 1
        order_list = all('.order')
        expect(order_list[0]).to have_content 'test3'
        expect(order_list[1]).to have_content 'test'
      end
    end

    context "依頼一覧画面で依頼を終了期限が早い順でソートする" do
      it "依頼一覧が終了期限が早い順で表示される" do
        click_link '依頼一覧'
        sleep 1
        select '終了期限が早い順', from: 'sort'
        sleep 1
        click_button '並べ替え'
        sleep 1
        order_list = all('.order')
        expect(order_list[0]).to have_content 'test'
        expect(order_list[1]).to have_content 'test3'
      end
    end

    context "依頼一覧画面から依頼を選んで受託する" do
      it "依頼に配達員がアサインされマイページに表示される" do
        click_link '依頼一覧'
        sleep 1
        click_link '依頼詳細', href: edit_order_path(3)
        sleep 1
        click_on '依頼受託'
        expect(page).to have_content '受託中の依頼'
      end
    end

    context "受託している依頼の配達完了を申請する" do
      it "配達完了ステータスが登録されマイページから受託依頼がなくなる" do
        click_link '依頼詳細'
        sleep 3
        click_button '配達完了'
        sleep 1
        expect(page).not_to have_content '受託中の依頼'
      end
    end
  end
end
