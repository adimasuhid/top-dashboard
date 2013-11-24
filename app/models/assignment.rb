class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :student

  validates :user_id, uniqueness: {scope: :student_id}
end
