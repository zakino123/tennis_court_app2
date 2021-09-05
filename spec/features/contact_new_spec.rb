require 'rails_helper'

RSpec.feature "New", type: :feature do
  describe "お問合せの作成" do
    before do
      visit new_contact_path
    end
    context "正しい値を入力した場合" do
      before do
        fill_in '名前', with: 'testuser'
        fill_in 'メールアドレス', with: 'testuser@example.com'
        fill_in 'お問合せ内容', with: 'テスト'
        click_button '送信'
      end
      it "問い合わせに成功" do
        expect(page).to have_selector('.alert-success', text: 'お問合せ内容を受け付けました。')
      end
    end
    context "誤った値を入力した場合" do
      before do
        fill_in '名前', with: ''
        fill_in 'メールアドレス', with: ''
        fill_in 'お問合せ内容', with: ''
        click_button '送信'
      end
      subject { page }
      it "問い合わせに失敗" do
        is_expected.to have_css('.alert-danger', text: '4つの誤りが確認されました。')
      end
    end

  end
end