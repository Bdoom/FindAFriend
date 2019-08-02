# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  before_action :update_ip_address

  def update_ip_address
    unless current_user.nil?
      @ip = request.remote_ip
      ipAddr = IpAddress.find_by(ip_address: @ip)
      if ipAddr.nil?
        ipAddr = IpAddress.create!([{ ip_address: @ip }])
        current_user.ip_address_id = ipAddr.first.id
        current_user.save!

        ipAddr.first.users << current_user
      else
        current_user.ip_address_id = ipAddr.id
        current_user.save!

        ipAddr.users << current_user
      end

    end
  end

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
