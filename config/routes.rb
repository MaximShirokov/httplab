Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'authenticate', to: 'authentication#authenticate'
      post 'register', to: 'users#register'

      resources :messages, only: %i[index create] do
        resource :like, only: :create, module: :messages
      end
    end
  end
end
