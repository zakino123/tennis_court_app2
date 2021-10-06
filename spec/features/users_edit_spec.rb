require 'rails_helper'

RSpec.feature 'Edit', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  describe 'ユーザー情報の変更' do
    before do
      visit user_create_path
      fill_in 'ニックネーム', with: 'testuser'
      fill_in 'メールアドレス', with: 'testuser@example.com'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード(確認用)', with: 'password'
      click_button 'ユーザー作成'
    end
    it '編集に成功' do
      click_link 'ユーザー情報編集'
      fill_in 'ニックネーム', with: 'test'
      click_button '変更'

      expect(user.reload.name).to eq 'test'
    end
    it '編集に失敗' do
      click_link 'ユーザー情報編集'
      fill_in 'メールアドレス', with: 'test@invalid'
      click_button '変更'

      expect(user.reload.email).to_not eq 'test@invalid'
    end
  end
end
