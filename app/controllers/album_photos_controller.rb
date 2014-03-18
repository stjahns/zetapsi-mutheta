class AlbumPhotosController < ApplicationController
  def create
    @album = Album.find(params[:album_id])
    @photo = @album.album_photos.create(params[:album_photo].permit(:image, :caption))
    @album.set_album_orders
    redirect_to edit_album_path(@album)
  end

  def update
    @album = Album.find(params[:album_id])
    @photo = @album.album_photos.find(params[:id])

    unless params[:album_photo][:move].nil?
      if params[:album_photo][:move] == "up"
        @album.move_up @photo
      end

      if params[:album_photo][:move] == "down"
        @album.move_down @photo
      end
    end
      
    @photo.update(photo_params)
    @album.set_album_orders
    redirect_to edit_album_path(@album)
  end

  def destroy
    @album = Album.find(params[:album_id])
    @photo = @album.album_photos.find(params[:id])
    @photo.destroy
    @album.set_album_orders
    redirect_to edit_album_path(@album)
  end

  private
    def photo_params
      params.require(:album_photo).permit(:caption)
    end
end
