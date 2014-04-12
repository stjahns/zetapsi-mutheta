class AddFrontpageSlideshowToAlbums < ActiveRecord::Migration
  def up
    add_column :albums, :frontpage, :boolean, default: false
  end
  def down
    remove_column :albums, :frontpage
  end
end
