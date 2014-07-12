FactoryGirl.define do
  #factory :user do
    #name     "Tester"
    #email    "tester@gmail.pl"
    #password "123456"
    #password_confirmation "123456"
  #end

	factory :user do
		sequence(:name)		{ |n| "Tester #{n}" }
		sequence(:email)	{ |n| "tester_#{n}@gmail.com" }
		password "123456"
		password_confirmation "123456"

		factory :admin do
      admin true
    end
	end

  factory :micropost do
    content "tralalala"
    user
  end
  
end