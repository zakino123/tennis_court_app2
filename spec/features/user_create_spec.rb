require 'rails_helper'

RSpec.describe "user_create", type: :feature do
  describe 'ユーザーを新規登録する場合' do
    context '正しい値を入力した場合' do
      before do
        visit user_create_path
        fill_in 'ニックネーム', with: 'testuser'
        fill_in 'メールアドレス', with: 'testuser@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード(確認用)', with: 'password'
        attach_file 'プロフィール画像', "#{Rails.root}/spec/fixtures/images/test.jpeg"
        click_button 'ユーザー作成'
      end
      it 'ユーザー作成成功メッセージ取得' do
        expect(page).to have_selector('.alert-success', text: 'テニスコートサーチにようこそ！')
      end
      it "画像アップロード" do
        expect(page).to have_selector("img[src$='test.jpeg']")
      end
    end

    context '誤った値を入力した場合' do
      before do
        visit user_create_path
        fill_in 'ニックネーム', with: ''
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        fill_in 'パスワード(確認用)', with: ''
        click_button 'ユーザー作成'
      end
      subject { page }
      it 'エラーメッセージ表示' do
        is_expected.to have_css('.alert-danger', text: '4つの誤りが確認されました。')
      end
    end
  end
end