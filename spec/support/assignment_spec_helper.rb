module AssignmentSpecHelper
  def fill_in_assignment(tutor_name, student_name)
    visit new_assignment_path
    select(tutor_name, from: 'assignment[user_id]')
    select(student_name, from: 'assignment[student_id]')
  end
end
