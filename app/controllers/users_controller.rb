# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find params[:id]
    @post = Post.new

    if @user != current_user

      if @user.profile_viewability_level == User.viewability_levels[:friends_only]
        unless @user.friends.include? current_user
          redirect_to root_path, notice: 'You are not friends with this user, or their profile is set to private.'
        end
      elsif @user.profile_viewability_level == User.viewability_levels[:only_me]
        redirect_to root_path, notice: 'You are not friends with this user, or their profile is set to private.'
      end
    end

    @page_title       = "#{@user.first_name} #{@user.last_name}"
    @page_description = @user.about_me
  end
end
