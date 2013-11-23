require 'spec_helper'

describe "Login Page", :type => :feature do

  describe "Sign in" do
    before :each do
      visit '/sign_in'
    end

    it "has a sign in button" do
      page.should have_content "Sign in"
    end

    context "Given Valid Information" do
      let(:user) {FactoryGirl.create(:user)}

      before :each do
        user_sign_in(user.email, user.password)
      end

      it "redirects to profile page" do
        current_path.should == profile_path
      end

      it "shows logout button" do
        page.should have_content "Sign Out"
      end

      it "shows a success message" do
        page.should have_content "Success! You have logged in."
      end
    end

    context "Given Invalid Information" do
      let(:user) {FactoryGirl.create(:user)}

      before :each do
        user_sign_in(user.email, "woot")
      end

      it "redirects to current page" do
        current_path.should == sign_in_path
      end

      it "shows a success message" do
        page.should have_content "Oops! Invalid email or password."
      end
    end

  end

  describe "Sign Out" do
    let(:user) {FactoryGirl.create(:user)}
    before :each do
      user_sign_in(user.email, user.password)
      click_link "Sign Out"
    end

    it "redirects to landing page" do
      current_path.should == root_path
    end

    it "shows confirmation message" do
      page.should have_content "Success! You have logged out."
    end

  end

  describe "Sign Up" do
    it "creates a new user" do
      expect{
        user_sign_up(
          first_name: "Thessa",
          last_name: "Cunanan",
          email: "mtdcunanan@gmail.com",
          password: "lalala",
          password_confirmation: "lalala"
        )
      }.to change(User,:count).by(1)
    end

    it "redirects to profile" do
      user_sign_up(
        first_name: "Thessa",
        last_name: "Cunanan",
        email: "mtdcunanan@gmail.com",
        password: "lalala",
        password_confirmation: "lalala"
      )
      current_path.should == profile_path
    end
  end

  describe "Authenticate User" do
    let(:user) {FactoryGirl.create(:user)}
    context "Given that I am not logged in" do
      it "redirects to sign in page on any page except landing" do
        visit students_path
        current_path.should == sign_in_path
      end

      it "redirects to landing page if going to landing page" do
        visit root_path
        current_path.should == root_path
      end
    end
  end

end
