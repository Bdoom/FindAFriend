# frozen_string_literal: true

Rails.application.routes.draw do


  devise_for :users, path:  '', path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" }
  resources :sessions, only: %i[new create destroy]

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
