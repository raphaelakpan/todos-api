require 'rails_helper'

RSpec.describe 'Authentication' do
  describe 'POST /auth/login' do
    # define a user
    let!(:user) { create(:user) }
    #set headers for authorization
    let(:headers) { valid_headers.except['Authorization'] }
    # define valid credentials
    let(:valid_credentials) do
      {
        email: user.email
        password: user.password
      }.to_json
    end
    # define invalid credentials
    let(:invalid_credentials) do
      {
        email: Faker::Internet.email
        password: Faker::Internet.password
      }.to_json
    end

    context 'when request is valid' do
      before { post '/auth/login', params: valid_credentials, headers: headers }

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when request is invalid' do
      before { post '/auth/login', params: invalid_credentials, headers: headers }

      it 'returns a failure message' do
        expect(json['message']).to match(/Invalid credentials/)
      end
    end
  end
end
