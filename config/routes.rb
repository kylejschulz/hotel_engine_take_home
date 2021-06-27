Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :search, only: [:create]
      resources :users, only: [:create]
      resources :sessions, only: [:create]
      
    end
  end
end
