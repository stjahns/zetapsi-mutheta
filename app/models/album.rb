class Album < ActiveRecord::Base
  has_many :album_photos

  def cover_image
    album_photos.count > 0 ?
      album_photos.first.image.url(:thumb)
      : "/assets/default_profilpic_200x250.gif"
  end
end
