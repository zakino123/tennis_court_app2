require 'rails_helper'

RSpec.feature "Edit", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:court) { FactoryBot.create(:court, user_id: user.id) }
  describe "コート情報の編集" do
    before do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      visit edit_court_path(court)
    end
    context "正しい値を入力した場合" do
      before do
        fill_in "施設名", with: "test2"
        fill_in "住所", with: "test2"
        click_button "コート情報変更"
      end
      it "作成に成功" do
        expect(court.reload.name).to eq "test2"
      end
    end
    context "誤った値を入力した場合" do
      before do
        fill_in "施設名", with: ""
        fill_in "住所", with: ""
        click_button "コート情報変更"
      end
      subject { page }
      it "作成に失敗" do
        expect(court.reload.name).to_not eq ""
      end
    end
  end
end