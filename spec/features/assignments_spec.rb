require 'spec_helper'

describe "Assignments Page" do
  let(:admin){FactoryGirl.create(:admin)}
  let(:student){FactoryGirl.create(:student)}

  describe "GET /assignments" do
    before :each do
      user_sign_in(admin.email, admin.password)
      visit assignments_path(mode: :tutor_view)
    end

    it "shows a tutor view link" do
      page.should have_link "By Tutor"
    end

    it "shows a student view link" do
      page.should have_link "By Student"
    end

    context "In tutor's view" do
      before :each do
        @assignment = FactoryGirl.create(:assignment, student: student, user: admin)
        visit assignments_path(mode: :tutor_view)
      end

      it "should show tutor's name as title" do
        find(".card strong").text.should == "Wat Admin"
      end

      it "should show students' name as content" do
        first(".card ul li").text.should == "Thessa Cunanan"
      end
    end

    context "In students view" do
      before :each do
        @assignment = FactoryGirl.create(:assignment, student: student, user: admin)
        visit assignments_path(mode: :student_view)
      end

      it "should show students' name as title" do
        find(".card strong").text.should == "Thessa Cunanan"
      end

      it "should show tutor's name as content" do
        first(".card ul li").text.should == "Wat Admin"
      end
    end

    context "add assignment button" do
      it "shows an add assignment button" do
        page.should have_css(".add-assignment")
      end

      it "redirects to new assignment page" do
        find(".add-assignment").click
        current_path.should == new_assignment_path
      end
    end

    context "delete assignment button" do
      before :each do
        @assignment = FactoryGirl.create(:assignment, student: student, user: admin)
        visit assignments_path(mode: :tutor_view)
      end

      it "shows a delete assignment button" do
        page.should have_css(".delete-assignment")
      end

      it "reduces assignment count by 1" do
        expect{find(".delete-assignment").click}.to change(Assignment, :count).by(-1)
      end

      it "redirects to assignments page" do
        find(".delete-assignment").click
        current_path.should == assignments_path
      end

      it "shows success" do
        find(".delete-assignment").click
        page.should have_content("Success")
      end
    end
  end

  describe "GET /assignments/new" do
    before :each do
      user_sign_in(admin.email, admin.password)
      student.save
      visit new_assignment_path
    end

    it "shows add new assignment" do
      page.should have_content("Add New Assignment")
    end

    it "shows a form" do
      page.should have_css("form#new_assignment")
    end

    context "click save assignment" do
      before :each do
        fill_in_assignment("Wat Admin", "Thessa Cunanan")
      end

      context "Given unique assignment" do
        it "increases assignment count by 1" do
          expect{click_on("Save Assignment")}.to change(Assignment,:count).by(1)
        end

        it "redirects to assignment page" do
          click_on("Save Assignment")
          current_path.should == assignments_path
        end

        it "shows success message" do
          click_on("Save Assignment")
          page.should have_content("Success")
        end
      end

      context "Given non-unique assignment or assigning same student to same tutor" do
        before :each do
          @assignment = FactoryGirl.create(:assignment, student: student, user: admin)
        end

        it "does not increase assignment count by 1" do
          expect{click_on("Save Assignment")}.to_not change(Assignment,:count)
        end

        it "redirects to assignment page" do
          click_on("Save Assignment")
          current_path.should == assignments_path
        end

        it "shows error message" do
          click_on("Save Assignment")
          page.should have_content("Oops")
        end
      end
    end
  end
end
