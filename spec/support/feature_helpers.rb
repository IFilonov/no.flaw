module FeatureHelpers
  def sign_in(user)
    visit new_male_session_path

    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on 'Enter'
  end
end
