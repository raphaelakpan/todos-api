module V1
  class ItemsController < ApplicationController
    before_action :set_todo
    before_action :set_item, except: [:index, :create]

    def index
      json_response(@todo.items)
    end

    def show
      json_response(@item)
    end

    def create
      @item = @todo.items.create!(item_params)
      json_response(@item, :created)
    end

    def update
      @item.update(item_params)
      json_response(@item)
    end

    def destroy
      @item.destroy
      head(:no_content)
    end

    private

    def set_todo
      @todo = @current_user.todos.find(params[:todo_id])
    end

    def set_item
      @item = @todo.items.find(params[:id])
    end

    def item_params
      params.permit(:name, :done)
    end
  end
end
