class AlbumsController < ApplicationController
    load_and_authorize_resource


    def index
        authorize! :index, Album

        if (current_user)
            @albums = Album.where(:private => false).or(Album.where(user_id: current_user.id)).page params[:page]

        else
            @albums = Album.where(:private => false).page params[:page]
        end

        @users = User.all
    end

    def show
        @album = Album.find(params[:id])
    end

    def new
        @album = Album.new
    end

    def edit
        authorize! :manage, Album, user_id: current_user.id
        @album = Album.find(params[:id])
    end

    def create
        authorize! :new, Album

        @album = Album.new(album_params)

        if @album.save
            redirect_to edit_album_path @album.id
        else
            render 'new'
        end
    end

    def update
        authorize! :manage, Album, user_id: current_user.id

        @album = Album.find(params[:id])

        if @album.update(album_params)
            redirect_to @album
        else
            render 'edit'
        end
    end

    def destroy
        authorize! :manage, Album, user_id: current_user.id

        @album = Album.find(params[:id])
        @album.destroy

        redirect_to albums_path
    end

private
    def album_params
        permitted = params.require(:album).permit(:title, :private).merge(user_id: current_user.id)
    end

end
