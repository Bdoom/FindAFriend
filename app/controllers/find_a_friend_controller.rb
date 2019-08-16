# frozen_string_literal: true

class FindAFriendController < ApplicationController

  def search
    @potential_friends = find_friends_algorithm

    render 'find_a_friend/search'
  end

  def get_friends_list
    render json: {friends: current_user.friends}, except: [:email]
  end

  def get_pending_friends
    render json: {pending_friends: current_user.pending_friends}, except: [:email]
  end

  def get_blocked_friends
    render json: {blocked_friends: current_user.blocked_friends}, except: [:email]
  end

  def get_requested_friends
    render json: {requested_friends: current_user.requested_friends}, except: [:email]
  end

  def find_friends
    render json: {potential_friends: find_friends_algorithm }, except: [:email]
  end

  def get_entire_friends_list
    render json: {friends: current_user.friends, pending_friends: current_user.pending_friends, blocked_friends: current_user.blocked_friends, requested_friends: current_user.requested_friends}, except: [:email]
  end

  def remove_friend
    other_user = User.find params[:id]
    if other_user != nil
      current_user.remove_friend(other_user)
    end
  end

  def accept_friend_request
    other_user = User.find params[:id]
    if other_user != nil
      current_user.accept_request(other_user)
    end
  end

  def send_friend_request
    user_to_friend = User.find params[:id]

    unless user_to_friend.nil?
      unless user_to_friend.id == current_user.id
        unless current_user.pending_friends.include? user_to_friend
          current_user.friend_request(user_to_friend)
          render json: { data: 'ok' }
        end
      end
    else
      render json: {data: 'failed' }
    end
  end

  def block_friend
    user_to_block = User.find params[:id]

    unless user_to_block.nil?
      current_user.block_friend(user_to_block)
    end
  end

  def unblock_friend
    user_to_block = User.find params[:id]

    unless user_to_block.nil?
      current_user.unblock_friend(user_to_block)
    end
  end

  def find_friends_algorithm
    locations = Location.near([current_user.location.latitude, current_user.location.longitude], 5)
    users_in_our_area = []
    potential_friends = []
    
    our_activities_string = []

    Activity.all.each do |activity|
      if current_user.following?(activity)
        our_activities_string.push(activity.name)
      end
    end

    #Like.joins("INNER JOIN users ON users.id = likes.liker_id AND likes.liker_id = $#{current_user.id}").each do |like|
    #  liker_user = User.find like.liker_id
    #  actvity_liked = Activity.find like.likeable_id
    #end
    
        
    locations.each do |location|
      users_in_our_area.push(location.user)
    end

    users_in_our_area.each do |user|
      other_users_liked_activities = []
      other_user = User.find user.id

      
      Activity.all.each do |activity|
        if other_user.following?(activity)
          other_users_liked_activities.push(activity.name)
        end
      end
      
      other_users_liked_activities.each do | activity_name |
        if our_activities_string.include? activity_name
          unless user.id == current_user.id
            unless current_user.friends_with?(user)
              unless current_user.pending_friends.include? user
                potential_friends.push(user)
              end
            end
          end
        end
      end
    end

    potential_friends.uniq
  end

  def dashboard
    render 'find_a_friend/dashboard'
  end


end
