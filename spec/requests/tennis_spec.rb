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
