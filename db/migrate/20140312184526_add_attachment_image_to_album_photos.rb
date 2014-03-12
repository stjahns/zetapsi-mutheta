class AddAttachmentImageToAlbumPhotos < ActiveRecord::Migration
  def self.up
    change_table :album_photos do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :album_photos, :image
  end
end
