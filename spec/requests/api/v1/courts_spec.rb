require 'rails_helper'

RSpec.describe 'Courts', type: :request do
  describe 'get search' do
    before do

    end
    context '住所を入力しない場合' do
      before do
        get "/api/v1/courts/search/"
      end
      it 'jsonは応答しない' do
        json = JSON.parse(response.body)
        expect(response.status).to eq(200)
        # expect(json[0]['title']).to match('test-subject1-title')
        # expect(json[1]['title']).to match('test-subject2-title')
        # expect(json[0]['teacher']['name']).to match('test-teacher1さん')
        # expect(json[0]['lectures'][0]['title']).to match('test-lecture1')
      end
    end
  end
end