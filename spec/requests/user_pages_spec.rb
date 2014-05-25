require 'spec_helper'

describe "User Pages" do
	subject { page }

	describe "signup page" do
		before { visit signup_path }

			it { should have_content('Sign up') }
			it { should have_title(full_title('Sign up')) }
	end

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }

			it { should have_content(user.name) }
			it { should have_title(user.name) }
	end

	describe "singup" do
		before { visit singup_path }

		let(:submit) { "Create my acount" }

		describe "with invalid information" do
			it "should not create a user" do
				expect( click_button submit ).to_not change(User, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "Name",					with: "Tester"
				fill_in "Email",				with: "tester@o2.pl"
				fill_in "Password",			with: "123456"
				fill_in "Confirmation",	with: "123456"
			end

			it "should create a user" do
				expect( click_button submit).to eq chnge(User, :count).by(1)
			end
		end
	end
				
end