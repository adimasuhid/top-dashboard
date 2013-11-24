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
      params.permit(:student_id, :user_id, :assignment_id)
    end
end
