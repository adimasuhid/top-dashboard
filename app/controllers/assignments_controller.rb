class AssignmentsController < ApplicationController
  def index
    if params[:mode] == "student_view"
      @students = Student.all.includes(:users)
      render :student_index
    else
      @users = User.all.includes(:students)
      render :tutor_index
    end
  end

  def new
    @assignment = Assignment.new
    @users = User.all
    @students = Student.all
  end

  def create
    @assignment = Assignment.new assignment_params
    message = if @assignment.save
                {success: "Assigned #{@assignment.student.name} to #{@assignment.user.name}"}
              else
                {error: "Failed to delete assignment"}
              end

    redirect_to assignments_path(mode: :tutor_view), flash: message
  end

  def destroy
    @assignment = Assignment.find(params[:id])
    tutor_name = @assignment.user.name
    student_name = @assignment.student.name

    message = if @assignment.destroy
                {success: "Removed assignment of #{tutor_name} to #{student_name}"}
              else
                {error: "Failed to delete assignment"}
              end

    redirect_to assignments_path(mode: :tutor_view), flash: message
  end

  private
    def assignment_params
      params.require(:assignment).permit(:student_id, :user_id, :assignment_id)
    end
end
