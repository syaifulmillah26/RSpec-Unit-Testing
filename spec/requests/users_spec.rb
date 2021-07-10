# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  include UsersHelper
  context 'GET API' do
    describe 'return success' do
      it 'get all users' do
        get '/api/users'
        expect(response).to have_http_status(200)
      end

      it 'get user detail' do
        get "/api/users/#{user.id}"
        expect(response).to have_http_status(200)
        expect(response.body).to_not be_empty
      end
    end

    describe 'return failed' do
      it 'get user detail' do
        get '/api/users/12'
        expect(response).to have_http_status(400)
      end
    end
  end

  context 'POST API' do
    let(:valid_params) { { user: { email: 'saiful@rubyh.co', password: '111111' } } }
    let(:invalid_params) { { user: { email: 'saiful@rubyh.co' } } }

    describe 'return success' do
      it 'post using valid params' do
        post '/api/users', params: valid_params
        expect(response).to have_http_status(201)
      end
    end

    describe 'return failed' do
      it 'post using invalid params' do
        post '/api/users', params: invalid_params
        expect(response).to have_http_status(400)
      end
    end
  end

  context 'PUT API' do
    let(:valid_params) { { user: { email: 'saiful+2@rubyh.com', password: '111111' } } }
    let(:invalid_params) { { user: { email: 'saiful#rubyh' } } }

    describe 'return success' do
      it 'using valid params' do
        put "/api/users/#{user.id}", params: valid_params
        expect(response).to have_http_status(200)
      end

      it 'activate user' do
        put "/api/users/#{user.id}/activate"
        expect(response).to have_http_status(200)
      end

      it 'inactivate user' do
        put "/api/users/#{user.id}/activate"
        expect(response).to have_http_status(200)
      end
    end

    describe 'return failed' do
      it 'using invalid params' do
        put "/api/users/#{user.id}", params: invalid_params
        expect(response).to have_http_status(400)
      end

      it 'user does not exist' do
        put '/api/users/12', params: invalid_params
        expect(response).to have_http_status(400)
      end

      it 'activate user' do
        put '/api/users/12/activate'
        expect(response).to have_http_status(400)
      end

      it 'inactivate user' do
        put '/api/users/12/inactivate'
        expect(response).to have_http_status(400)
      end
    end
  end

  context 'DELETE API' do
    describe 'return success' do
      it 'using valid params' do
        delete "/api/users/#{user.id}"
        expect(response).to have_http_status(200)
      end
    end

    describe 'return failed' do
      it 'user does not exist' do
        delete '/api/users/12'
        expect(response).to have_http_status(400)
      end
    end
  end
end
