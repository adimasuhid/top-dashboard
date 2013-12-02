class TimeLogsController < ApplicationController
  def index
    @time_logs = if current_user.admin?
                   TimeLog.all.includes(:student, :user).order(sortable)
                 else
                   current_user.time_logs.includes(:student, :user).order(sortable)
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

  def destroy
    @time_log = current_user.time_logs.find(params[:id])
    if @time_log.destroy
      redirect_to time_logs_path, flash: {success: "Removed Time Log"}
    else
      redirect_to time_logs_path, flash: {error: "Something's up. Contact Admin"}
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

    def sort_params
      params.permit(:sort,:direction)
    end

    def sortable
      order = case sort_params[:sort]
              when "student"
                "students.first_name"
              when "tutor"
                "users.first_name"
              when "date"
                "session_date"
              end

      "#{order} #{sort_params[:direction]}"
    end
end
