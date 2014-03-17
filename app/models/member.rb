class Member < ActiveRecord::Base

  before_create :create_remember_token
  before_save { self.email = email.downcase }

  has_attached_file :profile_photo,
    :styles=> {:medium => "300x300>", :thumb => "200x250#" },
    :default_url => "/assets/default_profilpic_200x250.gif"
  validates_attachment_content_type :profile_photo, :content_type => /image/

  validates :name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password,  length: { minimum: 6 },
                        if: :password

  has_secure_password

  def Member.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Member.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = Member.hash(Member.new_remember_token)
    end
end
