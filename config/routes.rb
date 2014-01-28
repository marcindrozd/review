Review::Application.routes.draw do

  root to: "application#index"

  get '/auth' => 'sessions#index'
  get '/auth/:provider/callback' => 'sessions#create'
  delete '/auth/signout' => 'sessions#destroy'

  resources :users, only: [:show, :index]
  resources :commits, only: [:index, :update]
  resources :projects, only: [:index, :show]
  resources :permissions, only: [:index, :show, :create, :update]
  resources :tickets, only: [:show]
  namespace :payloads do
    resource :github_hooks, only: [:create]
  end
end
