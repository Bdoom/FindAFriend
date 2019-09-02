# frozen_string_literal: true

class PostsController < ApplicationController
  def create
    @post = Post.new(sanitized_create_params)

    @post.user_id = current_user.id

    if @post.save
      render json: { status: 'ok' }
    else
      render json: { status: 'fail' }
    end
  end

  def get_recent_posts
    @user = User.find params[:user_id]
    @posts = @user.posts.paginate(page: params[:page], per_page: 10).order("created_at DESC")

    if @user != current_user
        if @user.profile_viewability_level == User.viewability_levels[:friends_only]
          unless @user.friends.include? current_user
            redirect_to root_path, notice: 'You are not friends with this user, or their profile is set to private.'
          end
        elsif @user.profile_viewability_level == User.viewability_levels[:only_me]
          redirect_to root_path, notice: 'You are not friends with this user, or their profile is set to private.'
        end
    end

    @posts_to_hide = []

    @posts.each do |post|
      if post.post_visibility == User.viewability_levels[:only_me]
        if @user != current_user
          @posts_to_hide.push(post)
        end
      end

      if post.post_visibility == User.viewability_levels[:friends_only]
        if !@user.friends.include? current_user
          @posts_to_hide.push(post)
        end
      end
    end

    @posts -= @posts_to_hide

    render json: { posts: @posts }
  end

  def sanitized_create_params
    params.require(:post).permit(:body, :post_visibility)
  end
end
