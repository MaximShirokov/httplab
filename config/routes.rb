Rails.application.routes.draw do
  resources :users, only: :index

  namespace :api do
    namespace :v1 do
      post 'authenticate', to: 'authentication#authenticate'
      post 'register', to: 'users#register'

      resources :messages, only: %i[index create] do
        resource :vote, only: :create, module: :messages
      end
    end
  end
end
