require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET login" do
    it "ログイン画面の表示に成功" do
      get login_path
      expect(response).to have_http_status(200)
    end
  end

  describe "destroyアクション" do
    before do
      @user = FactoryBot.build(:user)
      allow(User).to receive(:find_by).and_return(@user)
    end

    context "ユーザーがログアウトした時" do
      it "falseを返すこと" do

        delete logout_path

        expect(response).to have_http_status(302)
        expect(session[:user_id]).to be_falsey
      end
    end
  end
end
