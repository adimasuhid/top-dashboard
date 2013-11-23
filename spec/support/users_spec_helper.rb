module UsersSpecHelper
  def user_sign_in(email, password)
    visit '/sign_in'
    fill_in "email", with: email
    fill_in "Password", with: password
    click_button "Sign in"
  end

  def user_sign_up(options)
    visit '/sign_up'
    fill_in "first_name", with: options[:first_name]
    fill_in "last_name", with: options[:last_name]
    fill_in "email", with: options[:email]
    fill_in "password", with: options[:password]
    fill_in "password_confirmation", with: options[:password_confirmation]
    click_button "Sign Up"
  end

  def user_sign_out
    click_on "Sign Out"
  end

end
