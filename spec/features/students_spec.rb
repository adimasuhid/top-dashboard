require 'spec_helper'

describe "Students Page", :type => :features do
  describe "GET /students" do
    before :each do
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

  describe "Get /students/new" do
    before :each do
      visit new_student_path
    end

    it "renders success" do
      expect(page.status_code).to be(200)
    end

    it "contains a form" do
      page.should have_css('form#new_student')
    end

  end
end
