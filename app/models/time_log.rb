class TimeLog < ActiveRecord::Base
  belongs_to :student
  belongs_to :user
end
