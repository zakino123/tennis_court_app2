require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /user_create" do
    it "ユーザー新規登録の画面表示に成功" do
      get user_create_path
      expect(response).to have_http_status(200)
    end
  end

end
