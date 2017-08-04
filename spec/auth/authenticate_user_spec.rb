require 'rails_helper'

RSpec.describe AuthenticateUser do
  # setup test user
  let!(:user) { create(:user) }

  # initialize valid authentication object
  let(:valid_auth_obj) { described_class.new(user.email, user.password) }

  # initialize invalid authentication object
  let(:invalid_auth_obj) { described_class.new() }

  describe '#call' do
    # return token when valid request
    context 'when valid credentials' do
      it 'returns an auth token' do
        token = valid_auth_obj.call
        expect(token).not_to be_nil
      end
    end

    # raise Authentication Error when invalid request
    context 'when invalid credentials' do
      it 'raises an authentication error' do
        expect { invalid_auth_obj.call }
          .to raise_error(ExceptionHandler::AuthenticationError, /Invalid credentials/)
      end
    end
  end
end
