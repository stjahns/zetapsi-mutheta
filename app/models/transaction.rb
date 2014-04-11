class Transaction < ActiveRecord::Base
  belongs_to :member

  has_attached_file :receipt,
    :styles => { :preview => "300x400>" },
    :s3_permissions => :privaate

  validates_attachment_content_type :receipt, :content_type => /image/

  validates :description, presence: true
  validates :amount, :numericality => { :greater_than => 0 }

  TYPES = ["Charge", "Payment", "Reimbursement", "ReimbursementRequest"]

end
