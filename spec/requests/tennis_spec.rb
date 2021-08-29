require 'rails_helper'

RSpec.describe "Access to Tennis", type: :request do
  describe "GET /" do
    before { get root_path }
    example "ホーム画面の表示に成功" do
      expect(response).to have_http_status(200)
    end
    example "タイトル表示が正常" do
      assert_select "title", "テニスコートサーチ"
    end
  end

  describe "GET search" do
    example "検索画面の表示に成功" do
      get search_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET contact" do
    example "お問合せ/よくある質問画面の表示に成功" do
      get contact_path
      expect(response).to have_http_status(200)
    end
  end
end

# RSpec.describe 'Access to tennis home', type: :request do
#   before { get root_path }
#   example 'ホームページが正常に表示されているか確認' do
#       is_expected.to have_link nil, href: root_path, count: 3
#       is_expected.to have_link 'ログイン', href: login_path
#       is_expected.to have_link '新規登録', href: user_create_path
#     end
#   end
# end

# RSpec.describe "SiteLayoutTest", type: :feature do
#   before { visit root_path }
#   subject { page }
#   scenario "layout links" do
#     is_expected.to have_link nil, href: root_path, count: 3
#     is_expected.to have_link nil, href: login_path
#     is_expected.to have_link nil, href: user_create_path
#     is_expected.to have_link nil, href: search_path
#     is_expected.to have_link nil, href: contact_path
#   end
# end