class PhotoAlbumsController < ApplicationController

    def index
        @photo_albums = current_user.photo_albums
    end

    def show
        @photo_album = PhotoAlbum.find params[:id]
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
        params.require(:photo_album).permit(:title)
    end

end
