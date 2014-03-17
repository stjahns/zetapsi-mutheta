class AlbumPhoto < ActiveRecord::Base
  belongs_to :album
  has_attached_file :image,
    :styles=> {
      :frontpage => "1000x600#",
      :medium => "300x300>",
      :thumb => "200x250#" },
    :default_url => "/assets/default_profilpic_200x250.gif"
  validates_attachment_content_type :image, :content_type => /image/
  validates :image, presence: true
end
