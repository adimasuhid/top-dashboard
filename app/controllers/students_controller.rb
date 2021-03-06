class StudentsController < ApplicationController
  def index
    @students = current_user.admin? ? Student.all : current_user.students
  end

  def new
    @student = Student.new
    @year_levels = Student::YEAR_LEVEL
  end

  def edit
    @student = Student.find(params[:id])
    @year_levels = Student::YEAR_LEVEL
  end

  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(student_params)
      redirect_to students_path, :flash => {success: "Updated Artist"}
    else
      redirect_to edit_student_path, :flash => {error: "Fill in all details"}
    end
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to students_path, :flash => {success: "Created Artist"}
    else
      redirect_to new_student_path, :flash => {error: "Fill in all details"}
    end
  end

  private
    def student_params
      params.require(:student).permit(:first_name,:last_name,:school,:year_level)
    end
end
