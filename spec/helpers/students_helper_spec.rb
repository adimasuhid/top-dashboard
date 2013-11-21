require 'spec_helper'

describe StudentsHelper do
  describe "#select_options" do
    before :each do
      @student = FactoryGirl.create :student
    end

    it "should be an instance of array" do
      select_options(Student.all, :name).should be_an_instance_of Array
    end

    it "contains [1, 'Thessa Cunanan'] given YEAR_LEVEL" do
      select_options(Student.all, :name).first.first.should == 'Thessa Cunanan'
    end
  end

  describe "#select_options_hash" do
    it "should be an instance of array" do
      select_options_hash(Student::YEAR_LEVEL).should be_an_instance_of Array
    end

    it "contains ['Gr 1', 0] given YEAR_LEVEL" do
      select_options_hash(Student::YEAR_LEVEL).first.should == ['Gr 1', 0]
    end
  end
end
