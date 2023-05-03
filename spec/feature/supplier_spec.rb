require 'rails_helper'

RSpec.describe 'Suppliers feature', type: :feature do
  let!(:admin) { create(:admin, email: 'test@test.com', password: '111111') }
  let!(:supplier) { create(:supplier, name: 'Test Supplier a', email: 'test@test.com', phone: '03215472014', address: '123 Main St.') }

  before do
    login
  end

  scenario 'Admin can create new supplier with valid credentials' do
    visit '/suppliers/new'
    expect(page).to have_content('Create New Supplier')
    fill_in 'supplier_name', with: 'Test Supplier b'
    fill_in 'supplier_email', with: 'test2@test.com'
    fill_in 'supplier_phone', with: '03215472014'
    fill_in 'supplier_address', with: '456 Main St.'
    click_on 'Submit'

    expect(page).to have_content('Supplier Created Successfully')
    expect(Supplier.count).to eq(2)
    expect(Supplier.first.name).to eq('Test Supplier a')
    expect(Supplier.first.email).to eq('test@test.com')
    expect(Supplier.first.phone).to eq('03215472014')
    expect(Supplier.first.address).to eq('123 Main St.')
  end

  scenario 'Admin cant create new supplier with invalid credentials' do
    visit '/suppliers/new'
    expect(page).to have_content('Create New Supplier')
    fill_in 'supplier_name', with: ''
    click_on 'Submit'

    expect(page).to have_content("Name can't be blank")
    expect(Supplier.count).to eq(1)
  end

	scenario 'Admin can edit a supplier with valid credentials' do
		visit "/suppliers/#{supplier.id}/edit"
		expect(page).to have_content('Edit Supplier')
		fill_in 'supplier_name', with: 'Test Supplier b'
		fill_in 'supplier_email', with: 'test2@test.com'
		fill_in 'supplier_phone', with: '03215472014'
		fill_in 'supplier_address', with: '456 Main St.'
    attach_file('supplier_image', Rails.root + 'spec/support/assets/Unknown.jpeg')
		click_on 'Submit'
		expect(page).to have_content('Supplier Updated Successfully')
		expect(Supplier.count).to eq(1)
		expect(Supplier.first.name).to eq('Test Supplier b')
		expect(Supplier.first.email).to eq('test2@test.com')
		expect(Supplier.first.phone).to eq('03215472014')
		expect(Supplier.first.address).to eq('456 Main St.')
	end

	scenario 'Admin cant edit a supplier with invalid credentials' do
		visit "/suppliers/#{supplier.id}/edit"
		expect(page).to have_content('Edit Supplier')
		fill_in 'supplier_name', with: ''
		click_on 'Submit'
		expect(page).to have_content("Name can't be blank")
		expect(Supplier.count).to eq(1)
		expect(Supplier.first.name).to eq('Test Supplier a')
		expect(Supplier.first.email).to eq('test@test.com')
		expect(Supplier.first.phone).to eq('03215472014')
		expect(Supplier.first.address).to eq('123 Main St.')
	end

	scenario "User clicks delete button and confirms deletion" do
    visit '/suppliers'
    expect(page).to have_content('Manage Suppliers')
    expect(page).to have_content(supplier.name)
    find('a.btn-danger[href="' + supplier_path(supplier) + '"]').click
    expect(page).to have_content("Supplier Deleted successfully")
    expect(Supplier.find_by(id: supplier.id)).to be_nil
  end

  scenario "deleted supplier: failure case" do
    allow_any_instance_of(Supplier).to receive(:destroy).and_return(false)
    visit suppliers_path
    find('a.btn-danger[href="' + supplier_path(supplier) + '"]').click
    expect(current_path).to eq(suppliers_path)
    expect(Supplier.find_by(id: supplier.id)).to_not be_nil
  end

  scenario 'user cannot access non-existent supplier record' do
    visit '/suppliers/99999'

    expect(page).to have_content('Record Not Found')
    expect(page).to have_current_path(suppliers_path)
  end
  
end
