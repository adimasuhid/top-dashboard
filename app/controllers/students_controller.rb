class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def new
    @student = Student.new
    @year_levels = Student::YEAR_LEVEL
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
