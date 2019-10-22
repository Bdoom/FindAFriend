# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name birthdate gender sexuality race religion invite_code])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name birthdate gender sexuality race religion invite_code profile_viewability_level post_default_viewability_level profile_picture])
  end

  def logged_in?
    redirect_to root_path, notice: 'You are not logged in.' unless user_signed_in?
  end
end
