FactoryGirl.define do
  factory :user do
    email "wat@example.com"
    password "lala"
    password_confirmation "lala"
  end

  factory :admin, class: User do
    email "wat2@example.com"
    password "lala"
    password_confirmation "lala"
    role "admin"
  end
end
