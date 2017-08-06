Rails.application.routes.draw do
  resources :todos do
    resources :items
  end

  post '/auth/login' => 'authentication#authenticate'

  post '/signup', to: 'users#create'
end
