require 'spec_helper'

describe "Static pages"  do

	subject { page }
	
	describe "Home page" do
		before { visit root_path }

			it { should have_content('Sample App') }
			it { should have_title(full_title('')) }
			it { should_not have_title('| Home') }
	end

	describe "Help page" do
		before { visit help_path }
	
		it { should have_content('Help') }
		it { should have_title(full_title('Help')) }
	end

	describe "About page" do
		before { visit about_path }

		it { should have_content('About') }
		it { should have_title(full_title('About')) }
	end

	describe "Contact" do
		before { visit contact_path }

		it { should have_content('Contact') }
		it { should have_title(full_title('Contact')) }
	end

	describe "for signed-in users" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			FactoryGirl.create(:micropost, user: user, content: "tralalala")
			FactoryGirl.create(:micropost, user: user, content: "zoke fore")
			sign_in user
			visit root_path
		end

		it "should render the user's feed" do
			user.feed.each do |item|
				expect(page).to have_selector("li##{item.id}", text: item.content)
			end
		end

		it "micropost counts should be plural when count eq to 2 or more" do
			expect(page).to have_selector('span', text: 'microposts')
		end

		describe "micropost counts" do
			before { click_link "delete", match: :first }
			it "sould be singular when cuont eq 1" do
				expect(page).to have_selector('span', text: 'micropost')
			end
		end

		describe "microposts pagination" do
			before do
			 31.times { FactoryGirl.create(:micropost, user: user) }
			 sign_in user
			 visit root_path
			end
			after { user.microposts.delete_all }

			it { should have_selector('div.pagination') }
		end
	end

end