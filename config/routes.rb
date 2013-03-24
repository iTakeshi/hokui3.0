HokuiNet::Application.routes.draw do
  get "years/index"
  get "years/new"
  get  '/signup' => 'signup#new'
  post '/signup' => 'signup#create'
  get  '/signup/confirm/:secret_token' => 'signup#confirm', as: 'confirm_signup'

  get  '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  namespace :admin do
    resources :users, only: %i(index show) do
      member do
        patch 'approve'
        patch 'reject'
        patch 'promote'
        patch 'demote'
      end
    end

    resources :subjects, only: %i(index new create edit update)

    root to: 'index#index'
  end

  root to: 'index#index'
end
