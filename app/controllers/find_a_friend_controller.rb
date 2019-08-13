# frozen_string_literal: true

class FindAFriendController < ApplicationController

  def search
    @potential_friends = find_friends_algorithm

    render 'find_a_friend/search'
  end

  def find_friends_algorithm
    locations = Location.near([current_user.location.latitude, current_user.location.longitude], 5)
    users_in_our_area = []
    potential_friends = []
    
    our_activities_string = []
    our_user = User.find current_user.id

    Activity.all.each do |activity|
      if our_user.likes?(activity)
        our_activities_string.push(activity.name)
      end
    end
    
        
    locations.each do |location|
      users_in_our_area.push(location.user)
    end

    users_in_our_area.each do |user|
      other_users_liked_activities = []
      other_user = User.find user.id
      
      
      Activity.all.each do |activity|
        if other_user.likes?(activity)
          other_users_liked_activities.push(activity.name)
        end
      end
      
      other_users_liked_activities.each do | activity_name |
        if our_activities_string.include? activity_name
            potential_friends.push(user)
        end
      end
    end

    potential_friends.uniq
  end

  def dashboard
    render 'find_a_friend/dashboard'
  end


end
