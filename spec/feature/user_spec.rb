require 'rails_helper'

RSpec.describe 'User feature', type: :feature do
  let!(:admin) { create(:admin, email: 'test@test.com', password: '111111', role: 'Cashier') }
  let!(:product) { create(:product, name: 'Test Product') }
  let!(:brand) { create(:brand) }
  let!(:category) { create(:category) }
  let!(:supplier) { create(:supplier) }
  let!(:order) { create(:order) }
  let!(:order_item) { create(:order_item, order: order) }

  before do
    login
  end

  scenario 'User cannot goto non-authenticated routes' do
    visit '/products'
    expect(page).to have_content('Manage Products')
    visit '/products/new'
    expect(page).to have_content('You are not authorized to perform this action')
    visit '/products/1/edit'
    expect(page).to have_content('You are not authorized to perform this action')

    visit '/brands/new'
    expect(page).to have_content('You are not authorized to perform this action')
    visit '/brands/1/edit'
    expect(page).to have_content('You are not authorized to perform this action')

    visit '/categories/new'
    expect(page).to have_content('You are not authorized to perform this action')
    visit '/categories/1/edit'
    expect(page).to have_content('You are not authorized to perform this action')

    visit '/suppliers/new'
    expect(page).to have_content('You are not authorized to perform this action')
    visit '/suppliers/1/edit'
    expect(page).to have_content('You are not authorized to perform this action')

  end

end