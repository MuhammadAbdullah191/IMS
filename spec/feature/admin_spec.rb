require 'rails_helper'

RSpec.feature 'Admins', type: :feature do
  let!(:admin) { create(:admin, email: 'test@test.com', password: '111111') }
	let!(:admin_1) { create(:admin, email: 'test1@test.com', password: '111111') }
  let(:user) { create(:user) }

  before do
    login
  end

  scenario 'create a new admin' do
    visit new_admin_path

    fill_in 'admin_username', with: 'testadmin'
    fill_in 'admin_email', with: 'testadmin@example.com'
    fill_in 'admin_password', with: 'password'
    fill_in 'admin_password_confirmation', with: 'password'
    fill_in 'admin_phone', with: '03215472014'
    select 'Admin', from: 'Role'
    click_button 'Submit'

    expect(page).to have_content 'User Create Successfully'
    expect(page).to have_current_path(admins_path)
  end

	scenario 'create a new admin with invalid attributes' do
    visit new_admin_path

    fill_in 'admin_username', with: 'testadmin'
    fill_in 'admin_email', with: ''
    fill_in 'admin_password', with: 'password'
    fill_in 'admin_password_confirmation', with: 'password'
    fill_in 'admin_phone', with: '03215472014'
    select 'Admin', from: 'Role'
    click_button 'Submit'

    expect(page).to have_content 'Email can\'t be blank'
    expect(page).to have_current_path(admins_path)
  end

  scenario 'view a list of admins' do
    visit admins_path

    expect(page).to have_content admin.username
    expect(page).to have_content admin.email
    expect(page).to have_content admin.role.capitalize
    expect(page).to have_content admin.phone
  end

  scenario 'view details of an admin' do
    visit admin_path(admin)

    expect(page).to have_content admin.username
    expect(page).to have_content admin.email
    expect(page).to have_content admin.role.capitalize
  end

  scenario 'edit an admin' do
    visit edit_admin_path(admin_1)

    fill_in 'admin_username', with: 'newusername'
    fill_in 'admin_email', with: 'testadmin@example.com'
    fill_in 'admin_password', with: 'password'
    fill_in 'admin_password_confirmation', with: 'password'
    fill_in 'admin_phone', with: '03215472014'
    select 'Admin', from: 'Role'
    click_button 'Submit'

    expect(page).to have_content 'User Updated Successfully'
    expect(page).to have_current_path(admins_path)
    expect(page).to have_content 'newusername'
    expect(page).to have_content 'testadmin@example.com'
    expect(page).to have_content 'Admin'
    expect(page).to have_content '03215472014'
  end

	scenario 'create a new admin with invalid attributes' do
    visit edit_admin_path(admin_1)

    fill_in 'admin_username', with: 'testadmin'
    fill_in 'admin_email', with: ''
    fill_in 'admin_password', with: 'password'
    fill_in 'admin_password_confirmation', with: 'password'
    fill_in 'admin_phone', with: '03215472014'
    select 'Admin', from: 'Role'
    click_button 'Submit'

    expect(page).to have_content 'Email can\'t be blank'
    expect(page).to have_current_path(admin_path(admin_1))
  end

  scenario 'delete an admin' do
    visit admins_path

    expect(page).to have_content admin.username

    find('a.btn-danger[href="' + admin_path(admin_1) + '"]').click
    expect(page).to have_content("User Deleted Successfully")
    expect(Admin.find_by(id: admin_1.id)).to be_nil
  end

  scenario "deleted admin: failure case" do
    allow_any_instance_of(Admin).to receive(:destroy).and_return(false)
    visit admins_path
    find('a.btn-danger[href="' + admin_path(admin_1) + '"]').click
    expect(current_path).to eq(admins_path)
    expect(Admin.find_by(id: admin_1.id)).to_not be_nil
  end

	scenario 'admin cannot access non-existent admin record' do
    visit '/admins/99999'

    expect(page).to have_content('Admin Record Not Found')
    expect(page).to have_current_path(admins_path)
  end

end
