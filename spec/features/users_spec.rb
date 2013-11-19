require 'spec_helper'

describe "User Profile Page", :type => :feature do
  describe "GET /profile" do
    before :each do
      visit '/profile'
    end

    it "render success" do
      expect(page.status_code).to be(200)
    end


  end
end
