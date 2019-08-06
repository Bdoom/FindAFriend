# frozen_string_literal: true

Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :users

  resources :sessions, only: %i[new create destroy]

  get '/signup', to: 'users#new', as: 'signup'
  get '/login', to: 'sessions#new', as: 'login'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/findafriend', to: 'find_a_friend#search', as: 'findafriend'
  get '/dashboard', to: 'find_a_friend#dashboard', as: 'dashboard'
  
  resources :activities, only: [] do 
    collection do 
      put 'add_activity_to_user'
      patch 'add_activity_to_user'
      patch 'remove_activity_from_user'
      get 'get_activity_list'
    end 
  end

  get 'api/status', controller: 'api', action: 'status'

  root 'home#index'
end
