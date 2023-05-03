require 'rails_helper'

RSpec.describe 'Brand feature', type: :feature do
  let!(:admin) { create(:admin, email: 'test@test.com', password: '111111') }
	let!(:brand) { create(:brand, name: 'Test Brand a', description: 'This is a test brand') }

  before do
    login
  end

  scenario 'Admin can create new brand with valid credentials' do
    visit '/brands/new'
    expect(page).to have_content('Create New Brand')
    fill_in 'brand_name', with: 'Test Brand b'
    fill_in 'brand_description', with: 'This is a test brand'
    click_on 'Submit'

    expect(page).to have_content('Brand Created Successfully')
    expect(Brand.count).to eq(2)
    expect(Brand.first.name).to eq('Test Brand a')
    expect(Brand.first.description).to eq('This is a test brand')
  end

  scenario 'Admin cant create new brand with invalid credentials' do
    visit '/brands/new'
    expect(page).to have_content('Create New Brand')
    fill_in 'brand_name', with: 'Test'
    click_on 'Submit'

    expect(page).to have_content('Name is too short (minimum is 5 characters)')
    expect(Brand.count).to eq(1)
  end

	scenario 'Admin can edit a brand with valid credentials' do
    visit "/brands/#{brand.id}/edit"
    expect(page).to have_content('Edit Brand')
    fill_in 'brand_name', with: 'Test Brand b'
    fill_in 'brand_description', with: 'This is a modified test brand'
    attach_file('brand_image', Rails.root + 'spec/support/assets/Unknown.jpeg')
    click_on 'Submit'

    expect(page).to have_content('Brand Updated Successfully')
    expect(Brand.count).to eq(1)
    expect(Brand.first.name).to eq('Test Brand b')
    expect(Brand.first.description).to eq('This is a modified test brand')
  end

  scenario 'Admin cant edit a brand with invalid credentials' do
    visit "/brands/#{brand.id}/edit"
    expect(page).to have_content('Edit Brand')
    fill_in 'brand_name', with: 'Test'
    click_on 'Submit'

    expect(page).to have_content('Name is too short (minimum is 5 characters)')
    expect(Brand.count).to eq(1)
    expect(Brand.first.name).to eq('Test Brand a')
    expect(Brand.first.description).to eq('This is a test brand')
  end

	scenario "User clicks delete button and confirms deletion" do
    visit '/brands'
		expect(page).to have_content('Manage Brands')
		expect(page).to have_content(brand.name)
		find('a.btn-danger[href="' + brand_path(brand) + '"]').click
    expect(page).to have_content("Brand Deleted successfully")
    expect(Brand.find_by(id: brand.id)).to be_nil
  end

  it "deleted brand: failure case" do
    allow_any_instance_of(Brand).to receive(:destroy).and_return(false)
    visit brands_path
    find('a.btn-danger[href="' + brand_path(brand) + '"]').click
    expect(current_path).to eq(brands_path)
    expect(Brand.find_by(id: brand.id)).to_not be_nil
  end

  scenario 'user cannot access non-existent brand record' do
    visit '/brands/99999'

    expect(page).to have_content('Brand Record Not Found')
    expect(page).to have_current_path(brands_path)
  end

end
