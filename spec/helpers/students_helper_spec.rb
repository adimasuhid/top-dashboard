require 'spec_helper'

describe StudentsHelper do
  describe "#select_options" do
    it "should be an instance of array" do
      select_options(Student::YEAR_LEVEL).should be_an_instance_of Array
    end

    it "contains ['Gr 1', 0] given YEAR_LEVEL" do
      select_options(Student::YEAR_LEVEL).first.should == ['Gr 1', 0]
    end
  end
end
