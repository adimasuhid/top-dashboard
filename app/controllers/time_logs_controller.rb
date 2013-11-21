class TimeLogsController < ApplicationController
  def index
    @time_logs = current_user.time_logs.includes(:student)
  end

  def new
    @time_log = current_user.time_logs.new
    @students = Student.all
  end

  def edit

  end
end
