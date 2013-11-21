class TimeLogsController < ApplicationController
  def index
    @time_logs = current_user.time_logs.includes(:student)
  end

  def new
    @time_log = current_user.time_logs.new
    @students = Student.all
  end

  def edit
    @time_log = current_user.time_logs.find(params[:id])
    @students = Student.all
  end

  def create
    @time_log = current_user.time_logs.new(time_log_params)
    if @time_log.save
      redirect_to time_logs_path, :flash => {success: "Created Time Log"}
    else
      redirect_to new_time_log_path, :flash => {error: "Fill in all details"}
    end
  end

  def update
    #find out how to user strong params
    @time_log = current_user.time_logs.find(params[:id])
    if @time_log.update_attributes(time_log_params)
      redirect_to time_logs_path, flash: {success: "Updated Time Log"}
    else
      redirect_to edit_time_log_path, flash: {error: "Fill in all details"}
    end

  end

  private
    def time_log_params
      params.require(:time_log).permit(:session_date,:student_id,:duration,:notes)
    end
end
