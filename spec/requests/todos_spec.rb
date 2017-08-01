require 'rails_helper'

RSpec.describe 'Todos Api', type: :request do
  # initialize the test data
  let(:todos) { create_list(:todo, 10)}
  let!(:todo_id) { todos.first.id }

  # test suite for GET /todos
  describe 'GET /todos' do
    before { get '/todos' }

    it 'returns all todos' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  #text suite for POST /todos
  describe 'POST /todos' do
    let(:valid_params) { { title: 'Learn React', created_by: '323' } }

    context 'when params are valid' do
      before { post '/todos', params: valid_params }

      it 'creates a todo' do
        # binding.pry
        expect(json).not_to be_empty
        expect(json['title']).to eq(valid_params[:title])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when :title is empty' do
      before { post '/todos', params: { created_by: '2' } }

      it 'return a 422 status code' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message']).to match(/Title can't be blank/)
      end
    end
  end

  # test suite for GET /todos/:id
  describe 'GET /todos/:id' do
    before { get "/todos/#{todo_id}" }

    context 'when the record exist' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(todo_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:todo_id) { 100 }

      it 'returns not found message' do
        expect(json['message']).to match(/Couldn't find Todo with 'id'=100/)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end


   #text suite for PUT /todos/:id
  describe 'PUT /todos/:id' do
    let!(:valid_params) { { title: 'Updated React' } }

    context 'when the record exist' do
      before { put "/todos/#{todo_id}", params: valid_params }

      it 'updates the todo record' do
        expect(json['title']).to eq(valid_params[:title])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

   #text suite for DELETE /todos/:id
  describe 'DELETE /todos/:id' do
    before { delete "/todos/#{todo_id}" }

    context 'when record exists' do
      it 'returns 204 status code' do
        expect(response).to have_http_status(204)
      end
    end
  end
end
