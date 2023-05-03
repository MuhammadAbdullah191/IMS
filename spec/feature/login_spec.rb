require 'rails_helper'

RSpec.describe 'Login feature', type: :feature do
	let(:admin) { create(:admin, email: 'test@test.com', password: '111111') }
  
  scenario 'User logs in with valid credentials' do
		admin
    login
  end
  
  scenario 'User logs in with invalid credentials' do
		admin
    visit '/admins/sign_in'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '222222'
    click_button 'Log in'
    expect(page).to have_current_path('/admins/sign_in')
    expect(page).to have_content('Invalid Email or password')
  end

	scenario 'User logs out when it clicks on logout' do
		admin
    visit '/admins/sign_in'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '111111'
    click_button 'Log in'
    expect(page).to have_current_path('/')
    expect(page).to have_content('Welcome To IMS')
		click_button 'logout'
		expect(page).to have_current_path('/admins/sign_in')
		expect(page).to have_content('You need to sign in before continuing')
  end

end
