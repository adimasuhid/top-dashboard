class TimeLog < ActiveRecord::Base
  belongs_to :student
  belongs_to :user

  validates :student_id, :session_date, :duration, presence: true
  validates :duration, numericality: {greater_than: 0}
end
