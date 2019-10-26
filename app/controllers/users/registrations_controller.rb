# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

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
    unless result.nil?
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

      #resource.save(validate: false)
      resource.save
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    # super

    # For Rails 4
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

    # required for settings form to submit when password is left blank
    if account_update_params[:password].blank?
      account_update_params.delete('password')
      account_update_params.delete('password_confirmation')
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(account_update_params)
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case their password changed
      sign_in @user, bypass: true
      redirect_to after_update_path_for(@user)
    else
      render 'edit'
    end
  end

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
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name birthdate gender profile_viewability_level post_default_viewability_level])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name birthdate profile_viewability_level post_default_viewability_level])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  protected

  def update_resource(resource, params)
    if current_user.provider.nil? == false
      params.delete('current_password')
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end

end
