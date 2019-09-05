# frozen_string_literal: true

class PhotosController < ApplicationController
  def create
    @photo = Photo.new(create_sanitized_params)

    respond_to do |format|
      if @photo.save!
        format.html { redirect_to @photo, notice: 'Photo was successfully uploaded.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new, notice: 'Could not upload photo.' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @photo = Photo.find params[:id]
  end

  def create_sanitized_params
    params.require(:photo).permit(:title, :description, :image, :photo_album_id)
  end
end
