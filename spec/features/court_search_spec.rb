require 'rails_helper'

RSpec.feature "Search", type: :feature do
  let(:court) { FactoryBot.create(:court) }
  describe "検索機能" do
    before do
      visit root_path
    end
    context "正しい値を入力した場合" do
      before do
        fill_in 'location', with: "埼玉県蓮田市黒浜"
        click_button "検索"
      end
      it "検索に成功 " do
        expect(page).to have_content "〇〇件が見つかりました。"
      end
    end
    context "誤った値を入力した場合" do
      before do
        fill_in 'location', with: ""
        click_button "検索"
      end
      subject { page }
      it "検索に失敗" do
        expect(page).to have_current_path(root_path)
      end
    end
  end
end