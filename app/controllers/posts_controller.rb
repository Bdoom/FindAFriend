# frozen_string_literal: true

class PostsController < ApplicationController
  def create
    @post = Post.new(sanitized_create_params)

    @post.user_id = if current_user.nil?
                      1 # anonymous default account.
                    else
                      current_user.id
                    end

    if verify_recaptcha(model: @post) && @post.save
      respond_to do |format|
        format.js { render js: 'window.top.location.reload(true);' }
      end
    end
  end

  def get_recent_posts
    @user = User.find params[:user_id]
    @posts = @user.posts.paginate(page: params[:page], per_page: 10).order('created_at DESC')

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
        @posts_to_hide.push(post) if @user != current_user
      end

      next unless post.post_visibility == User.viewability_levels[:friends_only]

      @posts_to_hide.push(post) unless @user.friends.include? current_user
    end

    @posts -= @posts_to_hide

    render json: { posts: @posts }
  end

  def sanitized_create_params
    params.require(:post).permit(:body, :post_visibility, :board_thread_id)
  end
end
