require 'rails_helper'
RSpec.describe "ユーザー登録・ログイン・ログアウト機能", type: :system do
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

  describe "ユーザー登録のテスト" do
    context "ユーザーのデータがなくログインしていない状態" do
      it "カスタマーユーザー新規登録のテスト" do
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

        user_confirmation

        expect(page).to have_content 'メールアドレスが確認できました。'
      end

      it "配達員ユーザー新規登録のテスト" do
        visit new_user_registration_path
        fill_in 'user[family_name]', with: '配達'
        fill_in 'user[first_name]', with: '太郎'
        fill_in 'Eメール', with: 'courier@sample.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード（確認用）', with: 'password'
        fill_in '郵便番号', with: '234-5678'
        fill_in '住所', with: 'サンプル県サンプル市'
        fill_in '電話番号', with: '090-1234-5678'
        choose '配達員'
        click_button 'アカウント登録'

        user_confirmation

        expect(page).to have_content 'メールアドレスが確認できました。'
      end

      it "ログインしていない状態でマイページに入ろうとするとログイン画面に飛ぶテスト" do
        @customer_user = FactoryBot.create(:customer_user)
        visit home_path
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe "セッション機能のテスト" do
    before do
      @customer_user = FactoryBot.create(:customer_user)
      user_confirmation
      customer_login
    end

    context "ログインしていない状態でユーザーのデータがある場合" do
      it "ログインができること" do
        expect(page).to have_content 'ログインしました。'
      end
    end

    context "会員がログインしている状態" do
      it "ログアウトができること" do
        click_link 'ログアウト'
        expect {
        page.accept_confirm do
          expect(current_path).to eq root_path
        end
        }
      end
    end
  end

  describe "ユーザー情報編集・削除機能" do
    before do
      @customer_user = FactoryBot.create(:customer_user)
      user_confirmation
      customer_login
    end

    context "ログインしている状態で会員情報が編集できること" do
      it "会員情報が更新されマイページに戻ること" do
        click_link '会員情報編集'
        fill_in '住所', with: '変更'
        fill_in '現在のパスワード', with: 'password'
        click_button '更新'
        expect(page).to have_content 'アカウント情報を変更しました。'
      end
    end

    context "ログインしている状態でアカウント削除ができること" do
      it "アカウントが削除されindex画面に戻ること" do
        click_link '会員情報編集'
        click_button 'アカウント削除'
        expect {
        page.accept_confirm do
          expect(page).to have_content 'アカウントを削除しました。'
        end
        }
      end
    end
  end

  describe "カスタマーユーザーでログインしているときの機能" do
    before do
      @customer_user = FactoryBot.create(:customer_user)
      user_confirmation
      @courier_user = FactoryBot.create(:courier_user)
      user_confirmation
      @customer_user2 = FactoryBot.create(:customer_user2)
      user_confirmation
      @order1 = FactoryBot.create(:order1)
      customer_login
    end

    context "依頼一覧画面" do
      it "カスタマーは依頼一覧画面にアクセスできないこと" do
        visit orders_path
        expect(current_path).to eq home_path
      end
    end

    context "依頼詳細画面" do
      it "他人の依頼詳細画面にアクセスできないこと" do
        visit edit_order_path(1)
        expect(current_path).to eq home_path
      end
    end

    context "会話画面" do
      it "他人の依頼メッセージ画面にアクセスできないこと" do
        @conversation1 = FactoryBot.create(:conversation1)
        @message1 = FactoryBot.create(:message1)

        visit conversation_messages_path(1)
        expect(current_path).to eq home_path
      end
    end
  end

  describe "配達員ユーザーでログインしているときの機能" do
    before do
      @customer_user = FactoryBot.create(:customer_user)
      user_confirmation
      @courier_user = FactoryBot.create(:courier_user)
      user_confirmation
      @courier_user2 = FactoryBot.create(:courier_user2)
      user_confirmation
      @order2 = FactoryBot.create(:order2)
      courier_login
    end

    context "新規依頼作成画面" do
      it "配達員は新規依頼作成画面にアクセスできないこと" do
        visit new_order_path
        expect(current_path).to eq home_path
      end
    end

    context "依頼詳細画面" do
      it "他人が受けた依頼詳細画面にアクセスできないこと" do
        visit edit_order_path(2)
        expect(current_path).to eq home_path
      end
    end

    context "会話画面" do
      it "他人のメッセージ画面にアクセスできないこと" do
        @conversation2 = FactoryBot.create(:conversation2)
        @message2 = FactoryBot.create(:message2)

        visit conversation_messages_path(2)
        expect(current_path).to eq home_path
      end
    end
  end
end
