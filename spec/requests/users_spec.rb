require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /user_create" do
    example "ユーザー新規登録の画面表示に成功" do
      get user_create_path
      expect(response).to have_http_status(200)
    end
  end

  describe "showアクション" do
    before do
      @user = FactoryBot.create(:user)
    end
    example "ユーザー新規登録の画面表示に成功" do
      get user_path(@user)
      expect(response).to have_http_status(200)
    end
  end

  describe "indexアクション" do
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
        get users_path
        expect(response).to have_http_status(200)
      end     
    end
    context "未ログインのユーザーの場合" do
      it "ログイン画面にリダイレクト" do
        get users_path
        expect(response).to redirect_to login_path
      end
    end
       
  end

  describe "editアクション" do
    before do
      @user = FactoryBot.create(:user)
      @other_user = FactoryBot.create(:user)
    end
    context "正しいユーザーがログインした場合(フレンドリーフォワーディングも確認)" do
      before do
        get edit_user_path(@user)
        session_params = { session: { email: @user.email, password: @user.password } }
        post login_path, params: session_params
      end
      it "edit画面表示の成功" do
        expect(response).to have_http_status "302"
        expect(response).to redirect_to edit_user_path(@user)
      end
    end
    context "正しいユーザーがログインしていない場合" do 
      it "ログインページにリダイレクト" do
        get edit_user_path(@user)
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end
    context "違うアカウントの場合" do 
      before do
        session_params = { session: { email: @other_user.email, password: @other_user.password } }
        post login_path, params: session_params
      end
      it "ログインページにリダイレクト" do
        get edit_user_path(@user)
        expect(response).to have_http_status "302"
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "destroyアクション" do
    before do
      @user = FactoryBot.create(:user, admin: true)
      @other_user = FactoryBot.create(:user)
    end
    context "管理者ユーザーの場合" do
      before do
        get users_path(@user)
        session_params = { session: { email: @user.email, password: @user.password } }
        post login_path, params: session_params
      end
      it "ユーザーを削除に成功" do
        expect {
          delete user_path(@other_user), params: { id: @other_user.id }
        }.to change(User, :count).by(-1)
        expect(response).to redirect_to root_path
      end
    end
    context "管理者以外のユーザーの場合" do
      before do
        get users_path(@other_user)
        session_params = { session: { email: @other_user.email, password: @other_user.password } }
        post login_path, params: session_params
      end
      it "他ユーザーを削除できない" do
        delete user_path(@user), params: { id: @user.id }
        expect(response).to redirect_to root_path
      end
      it "自ユーザーを削除成功" do
        get edit_user_path(@other_user)
        expect {
          delete user_path(@other_user), params: { id: @other_user.id }
        }.to change(User, :count).by(-1)
        expect(response).to redirect_to root_path
      end
    end
  end
end
