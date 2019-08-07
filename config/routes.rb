# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', confirmations: 'users/confirmations', passwords: 'users/passwords', unlocks: 'users/unlocks' }
  
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
