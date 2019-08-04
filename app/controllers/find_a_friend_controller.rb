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

    render 'find_a_friend/search'
  end
end
