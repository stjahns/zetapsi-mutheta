class Member < ActiveRecord::Base
  has_attached_file :profile_photo,
    :styles=> {:medium => "300x300>", :thumb => "100x100" },
    :default_url => "/assets/default_profilpic.gif"
  validates_attachment_content_type :profile_photo, :content_type => /image/
  validates :name, presence: true
end
