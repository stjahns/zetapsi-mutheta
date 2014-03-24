class Member < ActiveRecord::Base

  # Include default devise modules. Others available are:
  #
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :profile_photo,
    :styles=> {:medium => "300x300>", :thumb => "200x250#" },
    :default_url => "/assets/default_profilpic_200x250.gif"
  validates_attachment_content_type :profile_photo, :content_type => /image/

  validates :name, presence: true

  validates :password,  length: { minimum: 6 },
                        if: :password
end
