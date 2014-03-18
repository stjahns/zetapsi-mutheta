class AddAlbumOrderToAlbumPhotos < ActiveRecord::Migration
  def change
    change_table :album_photos do |t|
      t.integer :album_order
    end
  end
end
