# frozen_string_literal: true

class PhotoAlbumsController < ApplicationController
  def index
    @photo_albums = current_user.photo_albums
  end

  def show
    @photo_album = PhotoAlbum.find params[:id]

    if @photo_album.viewability_level == PhotoAlbum.viewability_levels[:only_me]
      if current_user != @photo_album.user
        redirect_to root_path, notice: 'You do not have permission to view this album.'
      end
    end

    if @photo_album.viewability_level == PhotoAlbum.viewability_levels[:friends_only]
        unless @photo_album.user.friends.include? current_user
            redirect_to root_path, notice: 'You do not have permission to view this album.'
        end
    end

    @photos = @photo_album.photos
    @photos_to_remove = []

    @photos.each do |photo|
      if photo.viewability_level == Photo.viewability_levels[:friends_only]
        unless photo.photo_album.user.friends.include? current_user
          @photos_to_remove.push(photo)
        end
      end

      if photo.viewability_level == Photo.viewability_levels[:only_me]
        @photos_to_remove.push(photo)
      end
    end

    @photos -= @photos_to_remove

    @photo = Photo.new
  end

  def new
    @photo_album = PhotoAlbum.new
  end

  def create
    @photo_album = PhotoAlbum.new(create_sanitized_params)
    @photo_album.user = current_user

    respond_to do |format|
      if @photo_album.save!
        format.html { redirect_to @photo_album, notice: 'Photo Album was successfully created.' }
        format.json { render :show, status: :created, location: @photo_album }
      else
        format.html { render :new, notice: 'Could not create photo album.' }
        format.json { render json: @photo_album.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_sanitized_params
    params.require(:photo_album).permit(:title, :viewability_level)
  end
end
