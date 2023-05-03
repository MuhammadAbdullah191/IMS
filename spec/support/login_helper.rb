
RSpec.configure do |config|

  module LoginHelper
    def login
      visit '/admins/sign_in'
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: '111111'
      click_button 'Log in'
      expect(page).to have_content('Welcome To IMS')
    end

  end

  config.include LoginHelper
end
