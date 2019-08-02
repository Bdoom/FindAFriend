# frozen_string_literal: true

class UserInfosController < ApplicationController
  before_action :set_user_info, only: %i[show edit update destroy]

  # GET /user_infos
  # GET /user_infos.json
  def index
    redirect_to root_path, notice: 'You are not logged in to access this' if current_user.nil?
    @user_infos = UserInfo.all
  end

  # GET /user_infos/1
  # GET /user_infos/1.json
  def show
    redirect_to root_path, notice: 'You are not logged in to access this' if current_user.nil?
  end

  # GET /user_infos/new
  def new
    redirect_to root_path, notice: 'You are not logged in to access this' if current_user.nil?
    @user_info = UserInfo.new
  end

  # GET /user_infos/1/edit
  def edit
    redirect_to root_path, notice: 'You are not logged in to access this' if current_user.nil?
  end

  # POST /user_infos
  # POST /user_infos.json
  def create
    redirect_to root_path, notice: 'You are not logged in to access this' if current_user.nil?
    redirect_to root_path, notice: 'You can not create a new user info, you must edit your current one.' unless current_user.user_info.nil?

    @user_info = UserInfo.new(user_info_params)
    @user_info.user = current_user

    respond_to do |format|
      if @user_info.save
        format.html { redirect_to @user_info, notice: 'User info was successfully created.' }
        format.json { render :show, status: :created, location: @user_info }
        current_user.user_info = @user_info
        current_user.save!
      else
        format.html { render :new }
        format.json { render json: @user_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_infos/1
  # PATCH/PUT /user_infos/1.json
  def update
    redirect_to root_path, notice: 'You are not logged in to access this' if current_user.nil?

    respond_to do |format|
      if @user_info.update(user_info_params)
        format.html { redirect_to @user_info, notice: 'User info was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_info }
      else
        format.html { render :edit }
        format.json { render json: @user_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_infos/1
  # DELETE /user_infos/1.json
  def destroy
    redirect_to root_path, notice: 'You are not logged in to access this' if current_user.nil?

    @user_info.destroy
    respond_to do |format|
      format.html { redirect_to user_infos_url, notice: 'User info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_info
    @user_info = UserInfo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_info_params
    params.fetch(:user_info, {}).permit(:zipcode, :about_me)
  end
end
