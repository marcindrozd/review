Review::Application.routes.draw do

  root to: "application#index"

  get '/auth' => 'sessions#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'
  delete '/auth/signout' => 'sessions#destroy'

  namespace :api do
    namespace :v1 do
      resources :review_check, controller: 'projects', only: [:index]
      resources :trade_check, controller: 'trade', only: [:index]
    end
  end

  resources :users, only: [:show, :index, :update]
  resources :commits, only: [:index, :update]
  resources :projects, only: [:index, :show]
  resources :permissions, only: [:index, :show, :create, :update]
  resources :tickets, only: [:show]
  namespace :payloads do
    resource :github_hooks, only: [:create]
  end
end
