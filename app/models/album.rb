class Album < ActiveRecord::Base
  has_many :album_photos

  after_save :unique_frontpage_album 

  def unique_frontpage_album
    if frontpage?
      frontpage_albums = Album.where('frontpage = true AND id != ?', self.id)
      frontpage_albums.each do |album|
        album.frontpage = false
        album.save
      end
    end
  end

  def cover_image
    album_photos.count > 0 ?
      album_photos.first.image.url(:thumb)
      : "/assets/default_profilpic_200x250.gif"
  end

  def set_album_orders
    index = 0
    album_photos.each do | photo |
      photo.update_attribute(:album_order, index)
      index += 1
    end
  end

  def move_down(photo)

    if photo.album_order.nil?
      set_album_orders
    end

    swap_order(photo.album_order, photo.album_order + 1)
  end

  def move_up(photo)

    if photo.album_order.nil?
      set_album_orders
    end

    swap_order(photo.album_order, photo.album_order - 1)
  end

  def swap_order(index1, index2)
    photo1 = album_photos.where("album_order = ?", index1).first
    photo2 = album_photos.where("album_order = ?", index2).first
    unless photo1.nil? or photo2.nil?
      photo1.update_attribute(:album_order, index2)
      photo2.update_attribute(:album_order, index1)
    end
  end

end
