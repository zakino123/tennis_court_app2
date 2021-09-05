require 'rails_helper'

RSpec.describe "ゲストログイン", type: :request do
  describe "POST guest_login" do
    it "ログイン画面の表示に成功" do
      get new_court_path
      post guest_login_path
      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_court_path
    end
  end
end
