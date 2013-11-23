class AssignmentsController < ApplicationController
  def index
    @users = User.all.includes(:students)
  end
end
