# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user

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
    
    begin
      @current_user ||= User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      @current_user = nil
    end

    else
      @current_user = nil
    end
  end


end
