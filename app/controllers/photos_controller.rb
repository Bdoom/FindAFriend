# frozen_string_literal: true

class PhotosController < ApplicationController
  breadcrumb 'Photo Albums', :photo_albums_path, only: [:show]

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
    @photo_album = @photo.photo_album

    if @photo.viewability_level == Photo.viewability_levels[:only_me]
      if @photo.photo_album.user != current_user
        redirect_to root_path, notice: 'You do not have permission to view this album.'
      end
    end

    if @photo.viewability_level == Photo.viewability_levels[:friends_only]
      unless @photo.photo_album.user.friends.include? current_user
        redirect_to root_path, notice: 'You do not have permission to view this album.'
      end
    end

    @page_title       = @photo.title
    @page_description = @photo.description
    breadcrumb @photo.photo_album.title, photo_album_path(@photo.photo_album)
  end

  def delete_photo
    @photo = Photo.find params[:id]
    @photo_album = @photo.photo_album

    if @photo.photo_album.user == current_user
      @photo.image.purge_later
      @photo.delete
    end

    respond_to do |format|
      format.html { redirect_to @photo_album, notice: 'Photo was successfully deleted.' }
      format.json { render :show, status: :deleted, location: @photo_album }
    end
  end

  def create_sanitized_params
    params.require(:photo).permit(:title, :description, :image, :photo_album_id, :viewability_level)
  end
end
