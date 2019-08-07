# frozen_string_literal: true

class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :birthdate, :gender, :sexuality, :race, :religion, :about_me])
  end

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


end
