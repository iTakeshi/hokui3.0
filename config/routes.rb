HokuiNet::Application.routes.draw do
  get "freeml/index"
  get  '/signup' => 'signup#new'
  post '/signup' => 'signup#create'
  get  '/signup/confirm/:secret_token' => 'signup#confirm', as: 'confirm_signup'

  get    '/login' => 'sessions#new'
  post   '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resource :profile, only: %i(edit update)

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
    end

    root to: 'index#index'
  end

  get '/calendar' => 'index#calendar'
  get '/help' => 'index#help'

  root to: 'index#index'
end
