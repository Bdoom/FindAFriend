# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  before_action :validate_invite_code, only: [:create]

  def validate_invite_code
    invite_code = params[:user][:invite_code]
     
    if invite_code != nil
        validInviteCode = InviteCode.find_by(invite_code: invite_code) != nil
        if !validInviteCode
          redirect_to root_path, notice: 'Invite code is not valid.'
        end

        if validInviteCode
          invite = InviteCode.find_by(invite_code: invite_code)
          if invite.used
            redirect_to root_path, notice: 'Invite code has been used.'
          end
        end
      else
        redirect_to root_path, notice: 'Invite code is not valid.'
    end
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super

    @ip = request.remote_ip

    unless Rails.env.production?
      @ip = Net::HTTP.get(URI.parse('http://checkip.amazonaws.com/')).squish
    end

    result = Geocoder.search(@ip)
    if result != nil    
    @location = Location.new
    @location.latitude = result.first.latitude
    @location.longitude = result.first.longitude
    @location.country = result.first.country
    @location.city = result.first.city
    @location.state = result.first.region
    @location.zipcode = result.first.postal
    @location.user_id = resource.id
    @location.save!

    resource.location_id = @location.id

    resource.save!

    inv = InviteCode.find_by(invite_code: resource.invite_code)
    inv.used = true
    inv.save!

    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :birthdate, :gender, :sexuality, :race, :religion, :about_me, :invite_code])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :birthdate, :gender, :sexuality, :race, :religion, :about_me, :invite_code])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
