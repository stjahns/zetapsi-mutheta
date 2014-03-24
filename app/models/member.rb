class Member < ActiveRecord::Base

  # Include default devise modules. Others available are:
  #
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_attached_file :profile_photo,
    :styles=> {:medium => "300x300>", :thumb => "200x250#" },
    :default_url => "/assets/default_profilpic_200x250.gif"
  validates_attachment_content_type :profile_photo, :content_type => /image/

  validates :name, presence: true

  validates :password,  length: { minimum: 6 },
                        if: :password

  # don't require a password until member is confirmed
  # allows admins to create and invite new members
  def password_required?
    super if confirmed?
  end

  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

end
