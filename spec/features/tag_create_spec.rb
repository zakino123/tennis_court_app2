require 'rails_helper'

RSpec.feature 'New', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  jpeg_file_path = Rails.root.join('spec/fixtures/images/test.jpeg')
  describe 'タグ情報の作成' do
    before do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      click_link 'コート投稿'
    end
    context 'タグ情報を作成' do
      before do
        fill_in '施設名', with: '黒浜公園'
        fill_in '住所', with: '埼玉県黒浜市'
        fill_in '1時間あたりの料金', with: 200
        fill_in 'コート数', with: 5
        fill_in '予約URL', with: 'test'
        fill_in 'タグ付け(半角スペースで複数可能)', with: 'tag'
        attach_file '施設画像', jpeg_file_path
        click_button 'コート情報を投稿する'
      end
      it 'タグ検索成功' do
        expect(page).to have_content 'tag'
      end
    end
  end
end
