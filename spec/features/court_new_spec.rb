require 'rails_helper'

RSpec.feature "New", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:court) { FactoryBot.create(:court) }
  describe "コート情報の作成" do
    before do
      visit user_create_path
      fill_in 'ニックネーム', with: 'testuser'
      fill_in 'メールアドレス', with: 'testuser@example.com'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード(確認用)', with: 'password'
      click_button 'ユーザー作成'
      click_link "コート投稿"
    end
    context "正しい値を入力した場合" do
      before do
        fill_in "施設名", with: "test"
        fill_in "住所", with: "埼玉県蓮田市黒浜"
        fill_in "料金", with: 1
        fill_in "時間当たりの", with: 1
        fill_in "コート数", with: 1
        fill_in "備考", with: "test"
        attach_file '施設画像', "#{Rails.root}/spec/fixtures/images/test.jpeg"
        click_button "コート情報を投稿する"
      end
      it "作成に成功 " do
        expect(page).to have_selector('.alert-success', text: 'コート情報を受け付けました')
      end
      it "画像アップロード" do
        expect(page).to have_selector("img")
      end
    end
    context "誤った値を入力した場合" do
      before do
        fill_in "施設名", with: ""
        fill_in "住所", with: ""
        fill_in "料金", with: ""
        fill_in "時間当たりの", with: ""
        fill_in "コート数", with: ""
        fill_in "備考", with: ""
        click_button "コート情報を投稿する"
      end
      subject { page }
      it "作成に失敗" do
        is_expected.to have_css('.alert-danger', text: '7つの誤りが確認されました。')
      end
    end
  end
end