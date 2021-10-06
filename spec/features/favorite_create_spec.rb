require 'rails_helper'

RSpec.feature 'Create', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:court) { FactoryBot.create(:court) }

  describe 'お気に入り' do
    before do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      visit court_path(court)
    end
    context 'お気に入り登録' do
      before do
        find('.test').click
      end
      it 'お気に入り登録に成功 ' do
        expect(page).to have_css('.text-yellow-500')
      end
      it 'お気に入り解除に成功 ' do
        find('.test').click
        expect(page).to have_css('.text-gray-700')
      end
    end
  end
end
