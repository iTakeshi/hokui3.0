HokuiNet::Application.routes.draw do
  get  '/signup' => 'signup#new'
  post '/signup' => 'signup#create'
  get  '/signup/confirm/:secret_token' => 'signup#confirm', as: 'confirm_signup'

  get  '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  get  '/study' => 'study#index', as: 'study'
  get  '/study/:subject_title_en' => 'study#subject', as: 'study_subject'
  get  '/study/:subject_title_en/materials/exams'    => 'materials#exams',    as: 'study_subject_exams'
  get  '/study/:subject_title_en/materials/quizzes'  => 'materials#quizzes',  as: 'study_subject_quizzes'
  get  '/study/:subject_title_en/materials/notes'    => 'materials#notes',    as: 'study_subject_notes'
  get  '/study/:subject_title_en/materials/personal' => 'materials#personal', as: 'study_subject_personal'

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

    resources :years, only: %i(index new create) do
      resources :semesters, only: %i(index new create edit update)
    end

    root to: 'index#index'
  end

  root to: 'index#index'
end
