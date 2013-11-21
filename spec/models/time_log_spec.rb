require 'spec_helper'

describe TimeLog do
  it "changes nil duration to 0"
  it "validates presence of student"
  it "validates presence of date"
  it "validates presence of duration"
  it "validates duration as float"
  describe "#convert_session_date" do
    it "converts string date to date"
  end
end
