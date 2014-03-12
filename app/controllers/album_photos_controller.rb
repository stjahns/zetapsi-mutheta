class AlbumPhotosController < ApplicationController
  def create
    @album = Album.find(params[:album_id])
    @photo = @album.album_photos.create(params[:album_photo].permit(:image, :caption))
    redirect_to edit_album_path(@album)
  end

  def destroy
    @album = Album.find(params[:album_id])
    @photo = @album.album_photos.find(params[:id])
    @photo.destroy
    redirect_to edit_album_path(@album)
  end
end
