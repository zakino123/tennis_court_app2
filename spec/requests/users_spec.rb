require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /user_create" do
    it "should get user_create_path" do
      get "/user_create"
      expect(response).to have_http_status(:success)
    end
  end

end
