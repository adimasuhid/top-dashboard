require 'spec_helper'

describe "Login Page", :type => :feature do

  describe "Get /sign_in" do
    before :each do
      visit '/signin'
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

      it "should redirect to profile page"
    end

  end

end
