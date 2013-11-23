module UsersSpecHelper
  def user_sign_in(email, password)
    visit '/sign_in'
    fill_in "email", with: email
    fill_in "Password", with: password
    click_button "Sign in"
  end

  def user_sign_up(email, password, password_confirmation)
    visit '/sign_up'
    fill_in "email", with: email
    fill_in "password", with: password
    fill_in "password_confirmation", with: password_confirmation
    click_button "Sign Up"
  end

  def user_sign_out
    click_on "Sign Out"
  end

end
