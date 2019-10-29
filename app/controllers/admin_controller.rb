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
        thread.delete
    end

    respond_to do |format|
        format.js {render inline: "location.reload();" }
    end
  end

end
