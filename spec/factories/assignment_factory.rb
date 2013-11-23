FactoryGirl.define do
  factory :assignment do
    student {FactoryGirl.create(:student)}
    user {FactoryGirl.create(:user)}
  end
end
