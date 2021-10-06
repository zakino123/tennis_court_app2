require 'rails_helper'

RSpec.feature 'New', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:court) { FactoryBot.create(:court) }
  let(:favorite) { FactoryBot.create(:factorybot, user_id: user.id, court_id: court.id) }

  describe 'コートコメントの作成' do
    before do
      visit user_create_path
      fill_in 'ニックネーム', with: 'testuser'
      fill_in 'メールアドレス', with: 'testuser@example.com'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード(確認用)', with: 'password'
      click_button 'ユーザー作成'
      visit court_path(court)
    end
    context '正しい値を入力した場合' do
      before do
        fill_in 'comment_context', with: 'test'
        click_button 'コメントする'
      end
      it '作成に成功 ' do
        expect(page).to have_selector('.alert-success', text: 'コメントを投稿しました！')
      end
    end
    context '誤った値を入力した場合' do
      before do
        fill_in 'comment_context', with: ''
        click_button 'コメントする'
      end
      subject { page }
      it '作成に失敗' do
        is_expected.to have_css('.alert-danger', text: '投稿に失敗しました！')
      end
    end
  end
end
