class IndexController < ApplicationController
  skip_before_action :authorize_request, only: :index

  def index
    json_response({message: 'Welcome to the Todos API. Kindly Register or Log in to access the endpoints'})
  end
end
