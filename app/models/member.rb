class Member < ActiveRecord::Base

  before_save { self.email = email.downcase }

  has_attached_file :profile_photo,
    :styles=> {:medium => "300x300>", :thumb => "100x100" },
    :default_url => "/assets/default_profilpic.gif"
  validates_attachment_content_type :profile_photo, :content_type => /image/

  validates :name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password

end
