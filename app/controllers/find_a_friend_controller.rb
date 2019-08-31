# frozen_string_literal: true

class FindAFriendController < ApplicationController
  before_action :logged_in?

  def search
    @potential_friends = find_friends_algorithm

    render 'find_a_friend/search'
  end

  def get_friends_list
    render json: { friends: current_user.friends }, except: [:email]
  end

  def get_pending_friends
    render json: { pending_friends: current_user.pending_friends }, except: [:email]
  end

  def get_blocked_friends
    render json: { blocked_friends: current_user.blocked_friends }, except: [:email]
  end

  def get_requested_friends
    render json: { requested_friends: current_user.requested_friends }, except: [:email]
  end

  def find_friends
    render json: { potential_friends: find_friends_algorithm }, except: [:email]
  end

  def get_entire_friends_list
    render json: { friends: current_user.friends, pending_friends: current_user.pending_friends, blocked_friends: current_user.blocked_friends, requested_friends: current_user.requested_friends }, except: [:email]
  end

  def remove_friend
    other_user = User.find params[:id]
    current_user.remove_friend(other_user) unless other_user.nil?
  end

  def accept_friend_request
    other_user = User.find params[:id]
    current_user.accept_request(other_user) unless other_user.nil?
  end

  def send_friend_request
    user_to_friend = User.find params[:id]

    if user_to_friend.nil?
      render json: { data: 'failed' }
    else
      unless user_to_friend.id == current_user.id
        unless current_user.pending_friends.include? user_to_friend
          current_user.friend_request(user_to_friend)
          render json: { data: 'ok' }
        end
      end
    end
  end

  def block_friend
    user_to_block = User.find params[:id]

    current_user.block_friend(user_to_block) unless user_to_block.nil?
  end

  def unblock_friend
    user_to_block = User.find params[:id]

    current_user.unblock_friend(user_to_block) unless user_to_block.nil?
  end

  def set_user_location_if_required
    if current_user.location.nil?
      @ip = request.remote_ip

      unless Rails.env.production?
        @ip = Net::HTTP.get(URI.parse('http://checkip.amazonaws.com/')).squish
      end

      result = Geocoder.search(@ip)
      unless result.nil?
        @location = Location.new
        @location.latitude = result.first.latitude
        @location.longitude = result.first.longitude
        @location.country = result.first.country
        @location.city = result.first.city
        @location.state = result.first.region
        @location.zipcode = result.first.postal
        @location.user_id = current_user.id
        @location.save!

        current_user.location_id = @location.id

        current_user.save(validate: false)
      end
    end
  end

  def find_friends_algorithm
    set_user_location_if_required

    locations = Location.near([current_user.location.latitude, current_user.location.longitude], 5)
    users_in_our_area = []
    potential_friends = []

    our_activities_string = []

    Activity.all.each do |activity|
      if current_user.following?(activity)
        our_activities_string.push(activity.name)
      end
    end

    locations.each do |location|
      users_in_our_area.push(location.user)
    end

    users_in_our_area.each do |user|
      next if user.nil?

      other_users_liked_activities = []
      other_user = User.find user.id

      Activity.all.each do |activity|
        if other_user.following?(activity)
          other_users_liked_activities.push(activity.name)
        end
      end

      other_users_liked_activities.each do |activity_name|
        next unless our_activities_string.include? activity_name

        next if user.id == current_user.id

        next if current_user.friends_with?(user)

        unless current_user.pending_friends.include? user
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
