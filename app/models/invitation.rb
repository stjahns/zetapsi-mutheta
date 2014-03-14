class Invitation < ActiveRecord::Base

  include Rails.application.routes.url_helpers

  before_save { self.email = email.downcase }
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  validates_each :email do |record, attr, value|
    if Member.where('email = ?', value).any?
      record.errors.add attr, 'already taken by existing member.'
    end
  end

end
