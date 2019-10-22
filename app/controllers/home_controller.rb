# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    if current_user != nil
      redirect_to user_path(current_user)
    else
      render 'home/index'
    end
  end
end
