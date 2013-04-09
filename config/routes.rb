HokuiNet::Application.routes.draw do
  get "ml/index"
  get  '/signup' => 'signup#new'
  post '/signup' => 'signup#create'
  get  '/signup/confirm/:secret_token' => 'signup#confirm', as: 'confirm_signup'

  get    '/login' => 'sessions#new'
  post   '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resource :profile, only: %i(edit update) do
    collection do
      get  'password'
      post 'update_password'
    end
  end

  get  '/reset_password' => 'password_reset#new'
  post '/reset_password' => 'password_reset#create'
  get  '/set_new_password/:secret_token' => 'password_reset#set_password', as: 'set_new_password'
  post '/set_new_password/:secret_token' => 'password_reset#update_password'

  get   '/study' => 'study#index', as: 'study'
  scope '/study/:subject_title_en' do
    resources :materials, except: %i(index show), as: 'study_subject_materials' do
      member do
        get 'download'
      end

      collection do
        get 'exams'
        get 'quizzes'
        get 'notes'
        get 'personal_files'
      end
    end
  end

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

    resources :years, only: %i(index new create edit update) do
      resources :semesters, only: %i(index new create edit update)
      resource :ml_account, only: %i(new create edit update)
    end

    root to: 'index#index'
  end

  get '/freeml' => 'freeml#index'
  get '/freeml/:class_year/:freeml_id/download' => 'freeml#download', as: 'freeml_download'

  get '/ml' => 'ml#index'

  get '/calendar' => 'index#calendar'
  get '/help' => 'index#help'

  root to: 'index#index'
end
