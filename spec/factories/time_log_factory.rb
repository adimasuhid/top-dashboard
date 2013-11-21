FactoryGirl.define do
  factory :time_log do
    user {FactoryGirl.create :user}
    student {FactoryGirl.create :student}
    session_date DateTime.now
    duration 1.0
    notes "Test"
  end
end
