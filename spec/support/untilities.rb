def full_title(page_title)
	base_title = "Ruby on Rails Tutorial Sample App"
	return base_title if page_title.empty?
	return "#{base_title} | #{page_title}"
end

def valid_signin(user)
	fill_in "Email",    	with: user.email
	fill_in "Password", 	with: user.password
	click_button "Sign in"
end