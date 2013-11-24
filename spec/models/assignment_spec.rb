require 'spec_helper'

describe Assignment do
  let(:admin){FactoryGirl.create(:admin)}
  let(:student){FactoryGirl.create(:student)}

  describe "validates" do
    before :each do
      FactoryGirl.create(:assignment, student: student, user: admin)
      @assignment = FactoryGirl.build(:assignment, student: student, user: admin)
    end

    it "validates uniqueness of user_id with regards to student_id" do
      expect{@assignment.save!}.to raise_error
    end
  end
end
