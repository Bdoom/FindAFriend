# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    if current_user != nil
      redirect_to user_path(current_user)
    else
      @page_title       = 'Login or Sign up'
      @page_description = 'Connect with friends, make new friends, and share photos.'

      render 'home/index'
    end
  end
end
