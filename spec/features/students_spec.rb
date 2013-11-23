require 'spec_helper'

describe "Students Page", :type => :features do
  let(:user){FactoryGirl.create(:user)}

  describe "GET /students" do
    before :each do
      user_sign_in(user.email, user.password)
      visit students_path
    end

    it "renders success" do
      expect(page.status_code).to be(200)
    end

    context "add new student link" do
      it "shows an add a student link" do
        page.should have_link 'add a student'
      end

      it "redirects to new students page" do
        click_link("add a student")
        current_path.should == new_student_path
      end
    end

    context "edit student link" do
      before :each do
        @student = FactoryGirl.create :student
        visit students_path
      end

      it "shows an edit student link" do
        page.should have_link 'edit student'
      end

      it "redirects to edit  students page" do
        click_link("edit student")
        current_path.should == edit_student_path(@student)
      end
    end

    context "table of students" do
      it "shows a table with students as id" do
        page.should have_css('table#students')
      end

      context "Given a student named Thessa with year level Gr 1" do
        before :each do
          @user = FactoryGirl.create(:student)
          visit students_path
        end

        it "shows a row with Thessa" do
          page.should have_content('Thessa')
        end

        it "shows the year level as Gr 1" do
          page.should have_content('Gr 1')
        end
      end
    end
  end

  describe "Get /students/:id/edit" do
    before :each do
      @student = FactoryGirl.create(:student)
      user_sign_in(user.email, user.password)
      visit edit_student_path(@student)
    end

    it "renders success" do
      expect(page.status_code).to be(200)
    end

    it "contains a form" do
      page.should have_css("form#edit_student_#{@student.id}")
    end

    it "does not create a new student on save" do
      expect{click_button 'Save Student'}.not_to change(Student, :count)
    end

    context "editing a student" do
      before :each do
        @student = FactoryGirl.create(:student)
        visit edit_student_path(@student)
        @new_name = "Lala"
        fill_in("student[first_name]", with: "#{@new_name}")
      end

      context "given complete details" do

        it "updates first name" do
          expect do
            click_button 'Save Student'
            @student.reload
          end.to change(@student, :first_name)
        end

        it "shows a success message" do
          expect(page.status_code).to be(200)
        end

        it "redirects to students path" do
          click_button 'Save Student'
          current_path.should == students_path
        end
      end

      context "given incomplete details" do
        before :each do
          fill_in("student[first_name]", with: "")
        end

        it "shows an error message" do
          click_button 'Save Student'
          page.should have_content('Oops!')
        end

        it "updates first name" do
          expect do
            click_button 'Save Student'
            @student.reload
          end.not_to change(@student, :first_name)
        end
      end
    end
  end

  describe "Get /students/new" do
    before :each do
      user_sign_in(user.email, user.password)
      visit new_student_path
    end

    it "renders success" do
      expect(page.status_code).to be(200)
    end

    it "contains a form" do
      page.should have_css('form#new_student')
    end

    context "creating a student" do
      before :each do
        visit new_student_path
        fill_in("student[first_name]", with: "Thessa")
        fill_in("student[last_name]", with: "Cunanan")
        fill_in("student[school]", with: "SanLo")
        select('Gr 1', from: 'student[year_level]')
      end

      context "given complete details" do
        it "redirects to index path" do
          click_button 'Save Student'
          current_path.should == students_path
        end

        it "creates a student" do
          expect{ click_button 'Save Student' }.to change(Student, :count).by(1)
        end

        it "shows a success message" do
          click_button 'Save Student'
          page.should have_content('Success!')
        end
      end

      context "given incomplete details" do
        before :each do
          fill_in("student[school]", with: "")
        end
        it "redirects to new student path" do
          click_button 'Save Student'
          current_path.should == new_student_path
        end

        it "does not creates a student" do
          expect{ click_button 'Save Student'}.to change(Student, :count).by(0)
        end

        it "shows an error message" do
          click_button 'Save Student'
          page.should have_content('Oops!')
        end
      end
    end

  end
end
