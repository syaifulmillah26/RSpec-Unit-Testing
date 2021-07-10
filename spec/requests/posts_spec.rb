# frozen_string_literal: true

require 'rails_helper'
require 'byebug'

RSpec.describe 'Posts', type: :request do
  include PostsHelper

  context 'GET API' do
    describe 'return success' do
      it 'get all posts' do
        get '/api/posts', headers: { Authorization: "Bearer #{auth_token}" }
        expect(response).to have_http_status(200)
      end

      it 'get post detail' do
        get "/api/posts/#{post_created.id}", headers: { Authorization: "Bearer #{auth_token}" }
        expect(response).to have_http_status(200)
      end
    end

    describe 'return failed' do
      it 'get post detail' do
        get '/api/posts/12', headers: { Authorization: "Bearer #{auth_token}" }
        expect(response).to have_http_status(400)
      end
    end
  end

  context 'POST API' do
    let(:valid_params) { { post: { title: 'valid title', body: 'valid body', user_id: current_user.id, views: 1 } } }
    let(:invalid_params) { { post: { title: 'valid title', body: 'valid body', user_id: nil, views: 1 } } }

    describe 'return success' do
      it 'post using valid params' do
        post '/api/posts', params: valid_params, headers: { Authorization: "Bearer #{auth_token}" }
        expect(response).to have_http_status(201)
      end
    end

    describe 'return failed' do
      it 'post using invalid params' do
        post '/api/posts', params: invalid_params, headers: { Authorization: "Bearer #{auth_token}" }
        expect(response).to have_http_status(400)
      end
    end
  end

  context 'PUT API' do
    let(:valid_params) { { post: { title: 'new title' } } }
    let(:invalid_params) { { post: { titles: 'v' } } }

    describe 'return success' do
      it 'using valid params' do
        put "/api/posts/#{post_created.id}", params: valid_params, headers: { Authorization: "Bearer #{auth_token}" }
        expect(response).to have_http_status(200)
      end
    end

    describe 'return failed' do
      it 'using invalid params' do
        put "/api/posts/#{post_created.id}", params: invalid_params, headers: { Authorization: "Bearer #{auth_token}" }
        expect(response).to have_http_status(400)
      end

      it 'post does not exist' do
        put '/api/posts/12', params: invalid_params, headers: { Authorization: "Bearer #{auth_token}" }
        expect(response).to have_http_status(400)
      end
    end
  end

  context 'DELETE API' do
    describe 'return success' do
      it 'using valid params' do
        delete "/api/posts/#{post_created.id}", headers: { Authorization: "Bearer #{auth_token}" }
        expect(response).to have_http_status(200)
      end
    end

    describe 'return failed' do
      it 'post does not exist' do
        delete '/api/posts/12', headers: { Authorization: "Bearer #{auth_token}" }
        expect(response).to have_http_status(400)
      end
    end
  end
end
