require 'spec_helper'

describe TimeLog do
  let(:time_log){ FactoryGirl.build(:time_log)}

  it "validates presence of student_id" do
    time_log.student_id = nil
    expect{time_log.save!}.to raise_error
  end

  it "validates presence of session_date" do
    time_log.session_date = nil
    expect{time_log.save!}.to raise_error
  end

  it "validates presence of duration" do
    time_log.duration = nil
    expect{time_log.save!}.to raise_error
  end

  it "validates duration as float" do
    time_log.duration = "adsad"
    expect{time_log.save!}.to raise_error
  end

  it "validates duration as greater than 0" do
    time_log.duration = "0"
    expect{time_log.save!}.to raise_error
  end

end
