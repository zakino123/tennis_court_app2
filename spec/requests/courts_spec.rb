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
      @user = FactoryBot.create(:user)
      @court = FactoryBot.create(:court)
      session_params = { session: { email: @user.email, password: @user.password } }
      post login_path, params: session_params
    end
    example "コート新規登録の画面表示に成功" do
      get court_path(@court)
      expect(response).to have_http_status(200)
    end
  end

  describe "editアクション" do
    before do
      @user = FactoryBot.create(:user)
      @other_user = FactoryBot.create(:user)
      @admin_user = FactoryBot.create(:user, admin: true)
      @court = FactoryBot.create(:court, user_id: @user.id)
    end
    
    context "正しいユーザーがログインした場合" do
      before do
        session_params = { session: { email: @user.email, password: @user.password } }
        post login_path, params: session_params
      end
      it "edit画面表示の成功" do
        get edit_court_path(@court)
        expect(response).to have_http_status "200"
      end
    end
    context "管理ユーザーがログインした場合" do
      before do
        session_params = { session: { email: @admin_user.email, password: @admin_user.password } }
        post login_path, params: session_params
      end
      it "edit画面表示の成功" do
        get edit_court_path(@court)
        expect(response).to have_http_status "200"
      end
    end
    context "他ユーザーがログインした場合" do
      before do
        session_params = { session: { email: @other_user.email, password: @other_user.password } }
        post login_path, params: session_params
      end
      it "ホームにリダイレクト" do
        get edit_court_path(@court)
        expect(response).to have_http_status "302"
        expect(response).to redirect_to root_path
      end
    end
    context "ログインしていない場合" do
      it "ログインページにリダイレクト" do
        get edit_court_path(@court)
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "destroyアクション" do
    before do
      @user = FactoryBot.create(:user)
      @other_user = FactoryBot.create(:user)
      @admin_user = FactoryBot.create(:user, admin: true)
      @court = FactoryBot.create(:court, user_id: @user.id)
    end
    context "ユーザーが正しい場合" do
      before do
        get login_path
        session_params = { session: { email: @user.email, password: @user.password } }
        post login_path, params: session_params
      end
      it "コートを削除に成功" do
        get edit_court_path(@court)
        expect {
          delete court_path(@court), params: { id: @court.id }
        }.to change(Court, :count).by(-1)
        expect(response).to redirect_to root_path
      end
    end
    context "管理者ユーザーの場合" do
      before do
        get login_path
        session_params = { session: { email: @admin_user.email, password: @admin_user.password } }
        post login_path, params: session_params
      end
      it "コートを削除に成功" do
        get edit_court_path(@court)
        expect {
          delete court_path(@court), params: { id: @court.id }
        }.to change(Court, :count).by(-1)
      end
    end
    context "関係ないユーザーの場合" do
      before do
        get login_path
        session_params = { session: { email: @other_user.email, password: @other_user.password } }
        post login_path, params: session_params
      end
      it "コート情報を削除失敗" do
        get edit_court_path(@court)
        delete court_path(@court), params: { id: @court.id }
        expect(response).to redirect_to root_path
      end
    end
  end
end
