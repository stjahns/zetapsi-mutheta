class AlbumsController < ApplicationController

  before_action :authenticate_member!, except: [:show, :index]
  load_and_authorize_resource
  skip_authorize_resource :only => [:show, :index]

  def index
    @albums = Album.all
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to @album
    else
      render 'new'
    end
  end

  def show
    @album = Album.find(params[:id])
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      redirect_to @album
    else
      render 'edit'
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to albums_path
  end

  private

    def album_params
      params.require(:album).permit(:title, :frontpage)
    end

end
