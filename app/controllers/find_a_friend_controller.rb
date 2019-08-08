# frozen_string_literal: true

class FindAFriendController < ApplicationController

  def search
    @potential_friends = find_friends_algorithm


    render 'find_a_friend/search'
  end

  def find_friends_algorithm
    @locations = Location.near([current_user.location.latitude, current_user.location.longitude], 5)
    users_in_our_area = []
    potential_friends = []
    
    @locations.each do |location|
      users_in_our_area.push(location.user)
    end

    users_in_our_area.each do |user|
      

    end



  end

  def dashboard
    @our_activities = current_user.activities.to_a
    @all_activities = (Activity.all.to_a - @our_activities)

    render 'find_a_friend/dashboard'
  end


end
