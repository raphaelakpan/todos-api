module V2
  class TodosController < ApplicationController
    def index
      json_response({ message: "Version 2 implementation" })
    end
  end
end
