require 'spec_helper'
describe WelcomeHelper do
  describe "#landing?" do
    it "returns true if current path is root" do
      helper.request.stub(:fullpath).and_return('/')
      helper.landing?.should be_true
    end

    it "returns false if current path is not root" do
      helper.request.stub(:fullpath).and_return('/sign_in')
      helper.landing?.should be_false
    end
  end

  describe "#path" do
    it "returns true if param is part of the url" do
      helper.request.stub(:fullpath).and_return('/time_logs/new')
      helper.path?("time_logs").should be_true
    end

    it "returns false if param is not part of the url" do
      helper.request.stub(:fullpath).and_return('/time_logs/new')
      helper.path?("students").should be_false
    end
  end
end
