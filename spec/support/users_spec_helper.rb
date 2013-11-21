module UsersSpecHelper
  def user_sign_in(email, password)
    visit '/sign_in'
    fill_in "email", with: email
    fill_in "Password", with: password
    click_button "Sign in"
  end
end
