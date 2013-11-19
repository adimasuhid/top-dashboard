require 'spec_helper'

describe "User Profile Page", :type => :feature do
  describe "GET /profile" do
    let(:user) {FactoryGirl.create(:user)}

    before :each do
      visit '/sign_in'
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
      visit '/profile'
    end

    it "render success" do
      expect(page.status_code).to be(200)
    end


  end
end
