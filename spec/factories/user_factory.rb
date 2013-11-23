FactoryGirl.define do
  factory :user do
    first_name "Wat"
    last_name "User"
    email "wat@example.com"
    password "lala"
    password_confirmation "lala"
  end

  factory :admin, class: User do
    first_name "Wat"
    last_name "Admin"
    email "wat2@example.com"
    password "lala"
    password_confirmation "lala"
    role "admin"
  end
end
