# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :validate_user

  def validate_user
    redirect_to root_path unless user_signed_in?
  end

  def show
    @user = User.find params[:id]
  end
end
