class AlbumPhoto < ActiveRecord::Base
  belongs_to :album
  has_attached_file :image,
    :styles=> {
      :frontpage => "1000x600#",
      :medium => "1000x800>",
      :thumb => "200x250#",
      :navthumb => "150x150#" },
    :convert_options => {:medium => "-background transparent -gravity center -extent 1000x800"},
    :default_url => "/assets/default_profilpic_200x250.gif"
  validates_attachment_content_type :image, :content_type => /image/
  validates :image, presence: true
end
