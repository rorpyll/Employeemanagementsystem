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
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :employees
  resources :employees do
    collection do
      get :search
    end
  end

  namespace :hr do
    resources :employees do
      resources :leafs, only: :update do
        collection do
          get :index
        end
      end
    end

    resources :attendences
    get '/emp-attendance/:id', to: 'attendences#show_attendence', as: 'show_attendance'
    get '/search', to: 'attendences#search'
  end

  namespace :admin_main do
    resources :employees 
      resources :holidays
        resources :daily_tasks
  end

  get '/set_ip', to: 'dashboard#set_ip'
  get '/profile', to: 'employees#profile'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  patch '/accept/:id', to: 'tickets#decline_ticket', as: 'decline_ticket'
end
