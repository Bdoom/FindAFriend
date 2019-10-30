# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :is_admin

  def is_admin
    redirect_to :root_path unless current_user.admin?
  end

  def delete_multiple_threads
    thread_ids = params[:thread_ids]
    thread_ids.each do |thread_id|
      thread = BoardThread.find thread_id
      thread.soft_deleted = true
      thread.save
    end

    respond_to do |format|
      format.js { render inline: 'location.reload();' }
    end
  end

  def delete_threads_and_ban_users
    thread_ids = params[:thread_ids]
    thread_ids.each do |thread_id|
      thread = BoardThread.find thread_id
      thread.soft_deleted = true
      thread.save

      user = thread.user
      user.banned = true
      user.ban_reason = "You have been banned due to this post: #{thread.body}"
      user.save
    end

    respond_to do |format|
      format.js { render inline: 'location.reload();' }
    end
  end

  def delete_multiple_posts
    post_ids = params[:post_ids]
    post_ids.each do |post_id|
      post = Post.find post_id
      post.soft_deleted = true
      post.save
    end

    respond_to do |format|
      format.js { render inline: 'location.reload();' }
    end
  end

  def delete_posts_and_ban_users
    post_ids = params[:post_ids]
    post_ids.each do |post_id|
      post = Post.find post_id
      post.soft_deleted = true
      post.save

      user = thread.user
      user.banned = true
      user.ban_reason = "You have been banned due to this post: #{post.body}"
      user.save
    end
  end
end
