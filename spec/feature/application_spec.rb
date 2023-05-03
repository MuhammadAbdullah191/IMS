require 'rails_helper'

RSpec.describe 'Application feature', type: :feature do
  let!(:admin) { create(:admin, email: 'test@test.com', password: '111111') }
  let!(:product) { create(:product, name: 'Test Product') }
  let!(:order) { create(:order) }
  let!(:order_item) { create(:order_item, order: order) }

  before do
    login
  end

  scenario 'user cannot go to non-existant route' do
    visit '/brands99999'
    expect(page).to have_content('This route does not exist')
  end
  
end