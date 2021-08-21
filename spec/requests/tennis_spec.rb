require 'rails_helper'

RSpec.describe "Tennis", type: :request do
  describe "GET /" do
    it "should get root" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end

end
