require 'spec_helper'

describe "Time Logs", :type => :feature, :js => true do
  let(:user) {FactoryGirl.create(:user)}
  let(:admin) {FactoryGirl.create(:admin)}
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
        page.should have_css("i.fa-edit")
      end

      it "redirects to edit a time log page" do
        find("i.fa-edit").click
        current_path.should == edit_time_log_path(@time_log)
      end

      it "shows only on the current user (even admin)"
    end

    context "delete a time log link" do
      it "shows only the time log of a current user"
      it "sends a delete request"
    end

    context "forward to parents link" do
      it "shows an image of checkbox"
      it "shows checked when forwarded is true"
      it "shows checkbox when forwarded is false"
      it "updates checkbox when clicked"
    end

    context "parents are paid link" do
      it "shows an image of checkbox"
      it "shows checked when parents are paid"
      it "shows checkbox when parents are not paid"
      it "updates checkbox when clicked"
    end

    context "tutor is paid link" do
      it "shows an image of checkbox"
      it "shows checked when tutors are paid"
      it "shows checkbox when tutors are not paid"
      it "updates checkbox when clicked"
    end

    context "A table of my current logs" do
      before :each do
        @time_log = FactoryGirl.create(:time_log, user: admin, student: student, session_date: DateTime.now-1.day)
        @second_student = FactoryGirl.create(:student, first_name: "Lala")
        @second_time_log = FactoryGirl.create(:time_log, user: user, student: @second_student)
        visit time_logs_path
      end

      it "shows a table with time_logs as an id" do
        page.should have_css('table#time_logs')
      end

      context "Sortable" do
        context "By Student name" do
          before :each do
            find("#student").click
          end

          it "returns a sorted student name" do
            first("tr td").text.should == "Lala Cunanan"
          end
        end

        context "By Tutor name" do
          before :each do
            user_sign_in(admin.email, admin.password)
            visit time_logs_path
            find("#tutor").click
          end

          it "returns a sorted student name" do
            first("tr > td:nth-child(2)").text.should == "Wat Admin"
          end
        end

        context "By Date" do
          before :each do
            user_sign_in(admin.email, admin.password)
            visit time_logs_path
            find("#date").click
          end

          it "returns a sorted student name" do
            first("tr > td:nth-child(3)").text.should == (DateTime.now-1.day).strftime("%Y-%m-%d")
          end
        end
      end

      context "Given a student named Lala Cunanan and a tutor Wat User with a 1hr session" do
        it "shows a row with Thessa" do
          page.should have_content("Lala Cunanan")
        end

        it "shows a row with Wat User" do
          page.should have_content("Wat User")
        end

        it "shows 1 hr" do
          page.should have_content("1.0 hrs")
        end
      end
    end

    context "Given an admin user" do
      before :each do
        @user_time_log = FactoryGirl.create(:time_log, user: user, student: student)
        @admin_time_log = FactoryGirl.create(:time_log, user: admin, student: student)
        user_sign_in(admin.email, admin.password)
        visit time_logs_path
      end

      it "shows all time logs" do
        page.should have_content("Wat User")
        page.should have_content("Wat Admin")
      end

    end

    context "Given a tutor user" do
      before :each do
        @user_time_log = FactoryGirl.create(:time_log, user: user, student: student)
        @admin_time_log = FactoryGirl.create(:time_log, user: admin, student: student)
        user_sign_in(user.email, user.password)
        visit time_logs_path
      end

      it "shows only tutor's timelogs" do
        page.should have_content("Wat User")
        page.should have_no_content("Wat Admin")
      end
    end
  end

  describe "GET /time_logs/new" do
    before :each do
      @assignment = FactoryGirl.create(:assignment, user: user, student: student)
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
      context "given admin user" do
        before :each do
          @second_student = FactoryGirl.create(:student, first_name: "Lala")
          user_sign_in(admin.email, admin.password)
          fill_in_new_time_log(
            student_name: student.name,
            duration: 1.5,
            notes: "lalalala"
          )
        end

        it "shows all students" do
          page.should have_select('time_log[student_id]', :options=>["#{student.name}","#{@second_student.name}"])
        end
      end

      context "given tutor user" do
        before :each do
          @second_student = FactoryGirl.create(:student, first_name: "Lala")
          user_sign_in(user.email, user.password)
          fill_in_new_time_log(
            student_name: student.name,
            duration: 1.5,
            notes: "lalalala"
          )
        end

        it "shows only students that are assigned to me" do
          page.should have_select('time_log[student_id]', :options=>["#{student.name}"])
        end
      end

      context "given complete details" do
        before :each do
          fill_in_new_time_log(
            student_name: student.name,
            duration: 1.5,
            notes: "lalalala"
          )
        end

        it "creates a time log entry" do
          expect{ click_button 'Save Time Log' }.to change(TimeLog, :count).by(1)
        end

        it "redirects to index path" do
          click_button 'Save Time Log'
          current_path.should == time_logs_path
        end

        it "shows a success message" do
          click_button 'Save Time Log'
          page.should have_content('Success!')
        end
      end

      context "given incomplete details" do
        before :each do
          fill_in_new_time_log(
            student_name: student.name,
            duration: 0,
            notes: "lalalala"
          )
        end

        it "does not create a time log entry" do
          expect{ click_button 'Save Time Log' }.to change(TimeLog, :count).by(0)
        end

        it "redirects to new path" do
          click_button 'Save Time Log'
          current_path.should == new_time_log_path
        end

        it "shows an error message" do
          click_button 'Save Time Log'
          page.should have_content('Oops!')
        end
      end
    end
  end

  describe "GET /time_logs/:id/edit" do
    before :each do
      @time_log = FactoryGirl.create(:time_log, user: user, student: student)
      @assignment = FactoryGirl.create(:assignment, user: user, student: student)
      user_sign_in(user.email, user.password)
      visit edit_time_log_path(@time_log)
    end

    it "renders success" do
      expect(page.status_code).to be(200)
    end

    it "contains a form" do
      page.should have_css("form#edit_time_log_#{@time_log.id}")
    end

    context "editing a time log" do
      context "given complete details" do
        before :each do
          edit_time_log(
            time_log: @time_log,
            student_name: student.name,
            duration: 1.5,
            notes: "lalalala"
          )
        end

        it "updates a time log entry" do
          fill_in("time_log[duration]", with: 2)
          expect do
            click_button 'Save Time Log'
            @time_log.reload
          end.to change(@time_log, :duration)
        end

        it "redirects to index path" do
          click_button 'Save Time Log'
          current_path.should == time_logs_path
        end

        it "shows a success message" do
          click_button 'Save Time Log'
          page.should have_content('Success!')
        end
      end

      context "given incomplete details" do
        before :each do
          edit_time_log(
            time_log: @time_log,
            student_name: student.name,
            duration: 0,
            notes: "lalalala"
          )
        end
        it "does not update a time log entry" do
          expect do
            click_button 'Save Time Log'
            @time_log.reload
          end.not_to change(@time_log, :duration)
        end
        it "redirects to edit path" do
          click_button 'Save Time Log'
          current_path.should == edit_time_log_path(@time_log)
        end
        it "shows an error message" do
          click_button 'Save Time Log'
          page.should have_content('Oops!')
        end
      end

      context "forward to parents link" do
        it "shows an image of checkbox"
        it "shows checked when forwarded is true"
        it "shows checkbox when forwarded is false"
      end

      context "parents are paid link" do
        it "shows an image of checkbox"
        it "shows checked when parents are paid"
        it "shows checkbox when parents are not paid"
      end

      context "tutor is paid link" do
        it "shows an image of checkbox"
        it "shows checked when tutors are paid"
        it "shows checkbox when tutors are not paid"
      end

    end
  end

  describe "DELETE /time_logs/:id" do
    it "reducest time log count by 1"
  end
end
