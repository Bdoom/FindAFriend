# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])

    else
      @current_user = nil
    end
  end

  def handle_record_not_found
    redirect_to logout_path
  end
end
