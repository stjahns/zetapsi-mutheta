class AlbumPhoto < ActiveRecord::Base
  belongs_to :album
  has_attached_file :image,
    :styles=> {:medium => "300x300>", :thumb => "100x100" },
    :default_url => "/assets/default_profilpic.gif"
  validates_attachment_content_type :image, :content_type => /image/
  validates :image, presence: true
end
