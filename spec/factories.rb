FactoryGirl.define do
  factory :user do
    name     "Tester"
    email    "tester@gmail.pl"
    password "123456"
    password_confirmation "123456"
  end
end