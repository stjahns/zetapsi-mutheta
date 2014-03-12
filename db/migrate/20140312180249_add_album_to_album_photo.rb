class AddAlbumToAlbumPhoto < ActiveRecord::Migration
  def change
    change_table :album_photos do |t|
      t.references :album
    end
  end
end
