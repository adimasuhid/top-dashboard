require 'spec_helper'

describe "Navigation Bar", :type => :feature do
  let(:user) {FactoryGirl.create(:user)}

  before :each do
    visit '/sign_in'
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end

  context "students link" do
    it "shows a students button" do
      page.should have_link 'students'
    end

    it "redirects to students page" do
      click_link("students")
      current_path.should == students_path
    end
  end

  context "time logs link" do
    it "shows a logs button" do
      page.should have_link 'Time Logs'
    end

    it "redirects to students page" do
      click_link("Time Logs")
      current_path.should == time_logs_path
    end
  end

end
