# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', confirmations: 'users/confirmations', passwords: 'users/passwords', unlocks: 'users/unlocks' }
  
  get '/findafriend', to: 'find_a_friend#search', as: 'findafriend'
  get '/dashboard', to: 'find_a_friend#dashboard', as: 'dashboard'

  mount ActionCable.server => '/cable'
  
  resources :activities, only: [] do 
    collection do 
      put 'add_activity_to_user'
      patch 'add_activity_to_user'
      patch 'remove_activity_from_user'
      get 'get_activity_list'
    end 
  end

  resources :find_a_friend, only: [] do
    collection do
        get 'get_friends_list'
        get 'get_pending_friends'
        get 'get_blocked_friends'
        get 'get_requested_friends'

        patch 'send_friend_request'
        put 'send_friend_request'

        put 'block_friend'
        patch 'block_friend'

        put 'unblock_friend'
        patch 'unblock_friend'

        get 'find_friends'
        get 'get_entire_friends_list'

        put 'remove_friend'
        patch 'remove_friend'

        put 'accept_friend_request'
        patch 'accept_friend_request'

    end
  end

  get 'api/status', controller: 'api', action: 'status'

  root 'home#index'
end
