require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render json: { message: 'Success' }
    end
  end

  let!(:user) { create(:user, auth_token: 'valid_token') }

  describe 'GET #index' do
    context 'when user is authenticated' do
      before do
        request.headers['Authorization'] = "Bearer valid_token"
        get :index
      end

      it 'returns a success message' do
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'Success' })
      end

      it 'sets the current user' do
        expect(controller.current_user).to eq(user)
      end
    end

    context 'when user is not authenticated' do
      before do
        request.headers['Authorization'] = "Bearer invalid_token"
        get :index
      end

      it 'returns an unauthorized error' do
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Unauthorized' })
      end

      it 'does not set the current user' do
        expect(controller.current_user).to be_nil
      end
    end
  end
end
