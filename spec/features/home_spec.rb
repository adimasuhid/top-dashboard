require 'spec_helper'

describe "Home Page", :type => :feature  do
  describe "GET /" do
    before :each do
      visit '/'
    end

    it "render success" do
      expect(page.status_code).to be(200)
    end

    it "shows a login button" do
      page.should have_link 'Sign In'
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

  end
end
