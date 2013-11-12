FactoryGirl.define do
  factory :student do
    first_name "Thessa"
    last_name "Cunanan"
    school "UP"
    year_level Student::YEAR_LEVEL["Gr 1"]
  end
end
