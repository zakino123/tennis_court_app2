require 'rails_helper'

RSpec.describe "Contacts", type: :request do
  describe "GET /new" do
    example "お問合せフォームの画面表示に成功" do
      get new_contact_path
      expect(response).to have_http_status(200)
    end
  end
end
