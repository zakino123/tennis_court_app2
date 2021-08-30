require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET login" do
    it "ログイン画面の表示に成功" do
      get login_path
      expect(response).to have_http_status(200)
    end
  end
end
