class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :student
end
