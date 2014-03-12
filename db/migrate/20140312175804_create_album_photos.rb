class CreateAlbumPhotos < ActiveRecord::Migration
  def change
    create_table :album_photos do |t|
      t.text :caption

      t.timestamps
    end
  end
end
