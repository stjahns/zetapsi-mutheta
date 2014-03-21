class Event < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :start_time, presence: true

  validate :end_time_not_before_start_time
  def end_time_not_before_start_time
    unless start_time.nil? or end_time.nil?
      if start_time > end_time
        errors.add(:end_time, "event cannot end before it starts")
      end
    end
  end
end
