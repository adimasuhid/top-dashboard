require 'spec_helper'

describe Student do
  let(:user) { FactoryGirl.build :student}
  context "validations" do
    it "requires first_name" do
      user.first_name = ""
      expect{user.save!}.to raise_error
    end

    it "requires last_name" do
      user.last_name = ""
      expect{user.save!}.to raise_error
    end

    it "requires year_level" do
      user.year_level = nil
      expect{user.save!}.to raise_error
    end

    it "requires school" do
      user.year_level = ""
      expect{user.save!}.to raise_error
    end
  end

  context "year level" do
    it "has a year level constant" do
      Student::YEAR_LEVEL.present?.should be_true
    end
  end

  context "instance methods" do
    context "#year_level_name" do
      it "returns a string" do
        user.year_level_name.should be_an_instance_of String
      end
      it "should return Gr 1 if given 0" do
        user.year_level_name.should == "Gr 1"
      end
    end
  end

end
