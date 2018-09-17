class PhotosController < ApplicationController
    def create
        @album = Album.find(params[:album_id])
        authorize! :manage, @album, user_id: current_user.id

        params[:photo][:photo].each do |file|
            uploader = PhotoUploader.new
            File.open(file.tempfile) { |f| uploader.store!(f) }
            @photo = @album.photos.create(photo_params.merge(:path => uploader.url, :thumb => uploader.thumb.url))
        end

        redirect_to edit_album_path params[:album_id]
    end

    def update
        @album = Album.find(params[:album_id])
        authorize! :manage, @album, user_id: current_user.id
        @photo = @album.photos.find(params[:id])

        if @photo.update(photo_params)
            render json: @photo
        end
    end

    def destroy
        @album = Album.find(params[:album_id])
        authorize! :manage, @album, user_id: current_user.id

        @photo = @album.photos.find(params[:id])

        File.delete("#{Rails.public_path}#{@photo.path}")
        File.delete("#{Rails.public_path}#{@photo.thumb}")

        @photo.destroy
        redirect_to edit_album_path params[:album_id]
    end

private
    def photo_params
        params.require(:photo).permit(:title)
    end

end
