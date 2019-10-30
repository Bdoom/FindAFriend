# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :banned?

  def banned?
    if current_user.present? && current_user.banned?
      ban_reason = current_user.ban_reason
      sign_out current_user
      flash[:notice] = ban_reason
      root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name birthdate gender sexuality race religion])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name birthdate gender sexuality race religion profile_viewability_level post_default_viewability_level profile_picture])
  end

  def logged_in?
    redirect_to root_path, notice: 'You are not logged in.' unless user_signed_in?
  end
end
