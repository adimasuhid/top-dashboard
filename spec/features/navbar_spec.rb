require 'spec_helper'

describe "Navigation Bar", :type => :feature do
  let(:user) {FactoryGirl.create(:user)}
  let(:admin){FactoryGirl.create(:admin)}

  context "students link" do
    before :each do
      user_sign_in(user.email, user.password)
    end

    it "shows a students button" do
      page.should have_link 'Students'
    end

    it "redirects to students page" do
      click_link("Students")
      current_path.should == students_path
    end
  end

  context "time logs link" do
    before :each do
      user_sign_in(user.email, user.password)
    end

    it "shows a logs button" do
      page.should have_link 'Time Logs'
    end

    it "redirects to students page" do
      click_link("Time Logs")
      current_path.should == time_logs_path
    end
  end

  context "profile link" do
    before :each do
      user_sign_in(user.email, user.password)
    end

    it "shows a profile button" do
      page.should have_link 'Profile'
    end

    it "redirects to students page" do
      click_link("Profile")
      current_path.should == profile_path
    end

  end

  context "assignments link" do
    context "Given an admin user" do
      before :each do
        user_sign_in(admin.email, admin.password)
      end

      it "shows an assignments button" do
        page.should have_link 'Assignments'
      end

      it "redirects to assignments page" do
        click_link("Assignments")
        current_path.should == assignments_path
      end
    end

    context "Given a tutor" do
      before :each do
        user_sign_in(user.email, user.password)
      end

      it "does not show an assign students button" do
        page.should_not have_link 'Assignments'
      end
    end
  end

end
