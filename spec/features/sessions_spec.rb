require 'rails_helper'

RSpec.describe "user_login", type: :feature do
  describe 'ユーザーがログインする場合' do
    before do
      @user = FactoryBot.create(:user, email: "testuser@example.com")
    end
    context '正しい値を入力した場合' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: @user.email
        fill_in 'パスワード', with: @user.password
        click_button 'ログイン'
      end
      it 'ログイン画面の表示' do
        expect(page).to have_css("a", text: "マイページ")
        expect(page).to have_css("a", text: "ログアウト")
      end
    end

    context '誤った値を入力した場合' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        click_button 'ログイン'
      end
      subject { page }
      it 'エラーメッセージ表示' do
        is_expected.to have_selector('.alert-danger', text: 'メールアドレスかパスワードが間違っています。')
        is_expected.to have_current_path login_path
      end
    end
  end
end