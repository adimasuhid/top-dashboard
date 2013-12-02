require 'spec_helper'

describe TimeLogsHelper do
  describe "#display_hours" do
    before :each do
      @duration = 1.0
    end

    it "displays a number" do
      expect(display_hours(@duration)) =~ /%d\.%d hrs/
    end

    it "displays 'hrs'" do
      display_hours(@duration).include?("hrs")
    end
  end

  describe "#sortable" do
    it "creates a link"
    it "takes two required parameters" do
      pending #cannot test due to some routing issues
    end
    it "adds class"
    it "adds order"
  end

end
