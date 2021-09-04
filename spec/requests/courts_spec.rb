require 'rails_helper'

RSpec.describe "Courts", type: :request do
  describe "newアクション" do
    before do
      @user = FactoryBot.create(:user)
    end
    context "ログイン済みのユーザーの場合" do
      before do
        get login_path
        session_params = { session: { email: @user.email, password: @user.password } }
        post login_path, params: session_params
      end
      it "ユーザー一覧画面の表示に成功" do
        get new_court_path
        expect(response).to have_http_status(200)
      end     
    end
    context "未ログインのユーザーの場合" do
      it "ログイン画面にリダイレクト" do
        get new_court_path
        expect(response).to redirect_to login_path
      end
    end    
  end
  describe "showアクション" do
    before do
      @court = FactoryBot.create(:court)
    end
    example "ユーザー新規登録の画面表示に成功" do
      get court_path(@court)
      expect(response).to have_http_status(200)
    end
  end
end
