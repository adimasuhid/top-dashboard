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
        find(".card h2").text.should == "Wat Admin"
      end

      it "should show students' name as content" do
        first(".card ul li").text.should == "Thessa Cunanan"
      end
    end

    context "In students view" do
      it "should show tutor's name as content"
      it "should show students' name as title"
    end

    context "add assignment button" do
      it "shows an add assignment button" do
        page.should have_css(".add-assignment")
      end
      it "redirects to new assignment page"
    end

    context "delete assignment button" do
      it "shows a delete assignment button"
      it "reduces assignment count by 1"
      it "redirects to assignments page"
    end
  end
end
