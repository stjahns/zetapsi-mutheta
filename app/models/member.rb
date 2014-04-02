require 'role_model'

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

  has_many :transactions

  validates :name, presence: true

  validates :password,  length: { minimum: 6 },
                        if: :password

  validates_format_of :email, :with => Devise.email_regexp                          

  include RoleModel

  # declare valid roles -- do not change order, always append to end (due to role mask)
  roles :admin, :basic, :guest, :manage_albums, :manage_events, :manage_pages

  before_create do
    self.roles ||= [:basic]
  end

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

  def account_balance
    balance = 0
    self.transactions.each do |t|
      balance += t.balance_amount
    end
    return balance
  end

end
