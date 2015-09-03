Review::Application.routes.draw do
  mount EmberCLI::Engine => 'ember-tests' if Rails.env.development?

  root to: 'ember#bootstrap'

  get '/auth' => 'sessions#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'
  delete '/auth/signout' => 'sessions#destroy'

  namespace :api do
    namespace :v1 do
      resources :review_check, controller: 'projects', only: [:index]
      resources :trade_check, controller: 'trade', only: [:index]
    end

    namespace :v2 do
      resources :invitations, only: [:index, :show, :create]
      resources :users, only: [:show, :index, :update]
      resources :commits, only: [:index, :update]
      resources :projects, param: :name, only: [:index, :show]
      resources :tickets, only: [:show]
    end
  end

  namespace :payloads do
    resource :github_hooks, only: [:create]
  end

  get '/*path' => 'ember#bootstrap'
end
