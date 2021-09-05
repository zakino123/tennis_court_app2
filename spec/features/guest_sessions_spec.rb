require 'rails_helper'

RSpec.describe "guest_login", type: :feature do
  describe 'ユーザーがログインする場合' do
    before do
      visit root_path
      click_link "ゲストログイン"
    end
    it 'ログイン画面の表示' do
      expect(page).to have_css("a", text: "マイページ")
      expect(page).to have_css("a", text: "ログアウト")
    end
    it 'ログアウト後の画面の確認' do
      click_link "ログアウト"
      expect(page).to have_current_path(root_path)
      expect(page).to have_css("a", text: "ログイン")
      expect(page).to_not have_css("a", text: "ログアウト")
    end
  end
end