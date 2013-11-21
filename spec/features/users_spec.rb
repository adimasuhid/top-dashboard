require 'spec_helper'

describe "User Profile Page", :type => :feature do

  describe "GET /profile" do
    let(:user) {FactoryGirl.create(:user)}

    before :each do
      user_sign_in(user.email, user.password)
      visit '/profile'
    end

    it "render success" do
      expect(page.status_code).to be(200)
    end
  end
end
