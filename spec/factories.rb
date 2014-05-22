FactoryGirl.define do
  factory :user do
    name     "Tester"
    email    "tester@o2.pl"
    password "123456"
    password_confirmation "123456"
  end
end