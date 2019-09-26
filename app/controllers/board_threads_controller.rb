# frozen_string_literal: true

class BoardThreadsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def new
    @thread = BoardThread.new
  end

  def create
    @thread = BoardThread.new
    @thread.board_id = sanitized_params[:board]
    @thread.user_id = current_user.id
    @thread.title = sanitized_params[:title]
    @thread.body = sanitized_params[:body]

    @board = Board.find sanitized_params[:board]

    respond_to do |format|
      if @thread.save!
        format.html { redirect_to @thread, notice: 'Thread was successfully created.' }
        format.json { render :show, status: :created, location: @thread }
      else
        format.html { render :new, notice: 'Could not create thread.' }
        format.json { render json: @thread.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @thread = BoardThread.find params[:id]
    @posts = @thread.posts.order('created_at ASC')
    @post = Post.new

    @page_title       = @thread.title
    @page_description = @thread.body
    set_meta_tags nofollow: true
  end

  def sanitized_params
    params.require(:board_thread).permit(:title, :body, :board)
  end
end
