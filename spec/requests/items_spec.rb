require 'rails_helper'

RSpec.describe 'Items API', type: :request do
  # initialize the data
  let!(:todo) { create(:todo) }
  let!(:todo_items) { create_list(:item, 10, todo_id: todo.id) }
  let(:todo_id) { todo.id }
  let(:item_id) { todo_items.first.id }

  # Test suite for GET /todos/:todo_id/items
  describe 'GET /todos/:todo_id/items' do
    before { get "/todos/#{todo_id}/items" }

    context 'when todo exist' do
      it 'returns all the todo items' do
        expect(json.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when todo does not exit' do
      let!(:todo_id) { 100 }

      it 'returns an error message' do
        expect(json['message']).to match(/Couldn't find Todo with 'id'=100/)
      end

      it 'returns a 404 status' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Test suite for POST /todos/:todo_id/items
  describe 'POST /todos/:todo_id/items' do
    let(:valid_params) { { name: 'Watch Wes Bos', done: false } }
    let(:invalid_params) { {} }

    context 'when parameters are valid' do
      before { post "/todos/#{todo_id}/items", params: valid_params }

      it 'creates a todo item' do
        expect(json['name']).to eq(valid_params[:name])
      end

      it 'returns 201 status code' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when parameters are invalid' do
      before { post "/todos/#{todo_id}/items", params: invalid_params }

      it 'returns an error message' do
        expect(json['message']).to match(/Validation failed: Name can't be blank/)
      end

      it 'returns a 422 status code' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test suite for GET /todos/:todo_id/items/:id
  describe 'GET /todos/:todo_id/items/:id' do
    before { get "/todos/#{todo_id}/items/#{item_id}" }

    context 'when todo item exist' do
      it 'returns the item record' do
        expect(json['id']).to eq(item_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when todo item does not exist' do
      let(:item_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns an error message' do
        expect(json['message']).to match(/Couldn't find Item/)
      end
    end
  end

  # Test suite for PUT /todos/:todo_id/items/:id
  describe 'PUT /todos/:todo_id/items/:id' do
    let(:valid_params) { { name: 'Watch Dan Abramov' } }

    before { put "/todos/#{todo_id}/items/#{item_id}", params: valid_params }

    context 'when todo item exits' do
      it 'updates the item' do
        expect(json['name']).to eq(valid_params[:name])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when todo item does not exist' do
      let!(:item_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns an error message' do
        expect(json['message']).to match(/Couldn't find Item/)
      end
    end
  end

  # Test suite for DELETE /todos/:todo_id/items/:id
  describe 'DELETE /todos/:todo_id/items/:id' do
    before { delete "/todos/#{todo_id}/items/#{item_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
