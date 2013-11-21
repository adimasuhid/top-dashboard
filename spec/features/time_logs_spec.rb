require 'spec_helper'

describe "Time Logs", :type => :feature do
  let(:user) {FactoryGirl.create(:user)}
  let(:student) {FactoryGirl.create(:student)}
  let(:add_time_link) {"add a time log"}
  let(:edit_time_link) {"edit time log"}

  describe "GET /time_logs" do
    before :each do
      user_sign_in(user.email, user.password)
      visit time_logs_path
    end

    it "renders success" do
      expect(page.status_code).to be(200)
    end

    context "add a time log link" do
      it "shows an add time log link" do
        page.should have_link add_time_link
      end

      it "redirects to add a time log page" do
        click_link add_time_link
        current_path.should == new_time_log_path
      end
    end

    context "edit a time log link" do
      before :each do
        @time_log = FactoryGirl.create(:time_log, user: user, student: student)
        visit time_logs_path
      end

      it "shows an edit time log link" do
        page.should have_link edit_time_link
      end

      it "redirects to edit a time log page" do
        click_link edit_time_link
        current_path.should == edit_time_log_path(@time_log)
      end
    end

    context "a table of my current logs" do
      before :each do
        @time_log = FactoryGirl.create(:time_log, user: user, student: student)
        visit time_logs_path
      end

      it "shows a table with time_logs as an id" do
        page.should have_css('table#time_logs')
      end

      context "Given a student named Thessa Cunanan with a 1hr session" do
        it "shows a row with Thessa" do
          page.should have_content("Thessa Cunanan")
        end

        it "shows 1 hr" do
          page.should have_content("1.0 hrs")
        end
      end
    end
  end

  describe "GET /time_logs/new" do
    before :each do
      user_sign_in(user.email, user.password)
      visit new_time_log_path
    end

    it "renders success" do
      expect(page.status_code).to be(200)
    end

    it "contains a form" do
      page.should have_css("form#new_time_log")
    end

    context "creating a time log" do
      before :each do

      end
    end

  end
end
