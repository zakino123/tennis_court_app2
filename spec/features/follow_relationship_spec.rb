require 'rails_helper'

RSpec.feature 'Follow', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  describe 'フォロー/フォロー解除' do
    before do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      visit user_path(other_user)
    end
    context 'フォローが成功' do
      before do
        click_button 'フォロー'
      end
      it '作成に成功' do
        expect(page).to have_content 'フォロワー1'
      end
    end
    context 'フォロー解除が成功' do
      before do
        click_button 'フォロー'
        click_button 'フォロー解除'
      end
      it '作成に成功' do
        expect(page).to have_content 'フォロー'
      end
    end
  end
end
