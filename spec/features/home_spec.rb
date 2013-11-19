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


  end
end
