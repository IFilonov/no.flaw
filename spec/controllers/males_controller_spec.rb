require 'rails_helper'

RSpec.describe MalesController, type: :controller do
  let(:female) { create(:female) }

  describe 'POST #create' do
    before { sign_in(female) }

    context 'with valid attributes' do
      it 'create a new male' do
        post :create,
             params: { pair: { username: 'username', nickname: 'nickname', password: 'password' } }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      it 'create a new male' do
        post :create, params: { username: 'username' }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
