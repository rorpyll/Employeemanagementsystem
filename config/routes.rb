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
  resources :employees

  namespace :hr do
    resources :employees
  end

  namespace :'api' do
    namespace :'v1' do
      resources :employees
      resources :holidays 
    end
  end

  get '/set_ip', to: 'dashboard#set_ip'
  get '/profile', to: 'employees#profile'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  patch '/accept/:id', to: 'tickets#decline_ticket', as: 'decline_ticket'
  # patch '/accept/:id', to: "tickets#decline_ticket",  as: 'accept_ticket'

  get '/search', to: 'attendences#search'
end
