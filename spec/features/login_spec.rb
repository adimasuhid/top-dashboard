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
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it "redirects to profile page" do
        current_path.should == user_path(user.id)
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
        fill_in "Email", with: user.email
        fill_in "Password", with: "woot"
        click_button "Sign in"
      end

      it "redirects to current page" do
        current_path.should == current_path
      end

      it "shows a success message" do
        page.should have_content "Oops! Invalid email or password."
      end
    end

  end

  describe "Sign Out" do
    let(:user) {FactoryGirl.create(:user)}
    before :each do
      visit "/sign_in"
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
      click_link "Sign Out"
    end

    it "redirects to landing page" do
      current_path.should == root_path
    end

    it "shows confirmation message" do
      page.should have_content "Success! You have logged out."
    end

  end

  describe "Sign Up"

end
