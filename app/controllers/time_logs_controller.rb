class TimeLogsController < ApplicationController
  def index
    @time_logs = if current_user.admin?
                   TimeLog.all.includes(:student, :user)
                 else
                   current_user.time_logs.includes(:student, :user)
                 end
  end

  def new
    @time_log = current_user.time_logs.new
    @students = current_user.admin? ? Student.all : current_user.students
  end

  def edit
    @time_log = current_user.time_logs.find(params[:id])
    @students = current_user.admin? ? Student.all : current_user.students
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
