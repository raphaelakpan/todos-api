require 'rails_helper'

RSpec.describe 'Index API', type: :request do
  describe 'GET /' do
    before { get '/' }

    it 'returns a welcome message to the user' do
      expect(json['message']).to match(/Welcome to the Todos API. Kindly Register or Log in to access the endpoints/)
    end
  end
end
