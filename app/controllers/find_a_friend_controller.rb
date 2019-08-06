# frozen_string_literal: true

class FindAFriendController < ApplicationController

  before_action :authenticate_user!

  def authenticate_user!
    if current_user.nil?
      redirect_to root_path, notice: "Please Login to view that page!"
    end
  end

  def search
    
    @locations = Location.near([current_user.location.latitude, current_user.location.longitude], 5)
    @potential_friends = find_friends_algorithm


    render 'find_a_friend/search'
  end

  def find_friends_algorithm
    []
  end

  def dashboard
    @our_activities = current_user.activities.to_a
    @all_activities = (Activity.all.to_a - @our_activities)

    render 'find_a_friend/dashboard'
  end


end
