class Transaction < ActiveRecord::Base
  belongs_to :member
  has_attached_file :receipt, :styles=> { :preview => "300x400>" }
  validates_attachment_content_type :receipt, :content_type => /image/

  TYPES = ["Charge", "Payment", "Reimbursement", "ReimbursementRequest"]

end
