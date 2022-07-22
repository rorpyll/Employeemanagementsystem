# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tickets
  mount Ckeditor::Engine => '/ckeditor'
  resources :roles
  resources :skills
  resources :designations
  resources :leafs
  resources :attendences do
    collection do
      get :update_attendence
    end
  end
  resources :salaries
  resources :daily_tasks
  get 'dashboard/index'
  root 'dashboard#index'
  resources :performances
  resources :holidays
  devise_for :employees
  resources :employees do
    collection do
      get :search
    end
  end

  namespace :hr do
    resources :monthly_salaries
    resources :employees do
      resources :leafs, only: :update do
        collection do
          get :index
        end
      end
      patch '/update_leave', to: 'employees#update_leave_balance', as: 'update_leave_balance'
    end

    resources :attendences
    get '/emp-attendance/:id', to: 'attendences#show_attendence', as: 'show_attendance'
    get '/search', to: 'attendences#search'
  end

  namespace :api do
    namespace :v1 do
      resources :leafs, only: %i[index create update]
    end
  end

  namespace :admin_main do
    resources :holidays
    resources :tickets, only: %i[index show update] do
      resources :comments, only: [:create]
    end
    resources :employees
    resources :monthly_salaries, except: %i[destroy edit]
  end

  get '/set_ip', to: 'dashboard#set_ip'
  get '/profile', to: 'employees#profile'

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'Employee', at: 'auth'
      resources :employees, only: %i[show] do
        collection do
          put 'update_password'
        end
      end
    end
  end

  patch '/accept/:id', to: 'tickets#decline_ticket', as: 'decline_ticket'
end
