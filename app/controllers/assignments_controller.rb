class AssignmentsController < ApplicationController
  def index
    @users = User.all
  end
end
