require 'rails_helper'

RSpec.describe "Tennis", type: :request do
  describe "GET /" do
    it "should get root" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET search" do
    it "should get search_path" do
      get "/search"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET question" do
    it "should get question_path" do
      get "/question"
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "GET contact" do
    it "should get contact_path" do
      get "/contact"
      expect(response).to have_http_status(:success)
    end
  end
end
