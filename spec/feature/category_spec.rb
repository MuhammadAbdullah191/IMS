require 'rails_helper'

RSpec.describe 'Categories feature', type: :feature do
  let!(:admin) { create(:admin, email: 'test@test.com', password: '111111') }
  let!(:category) { create(:category, name: 'Test Category a', description: 'This is a test category') }

  before do
    login
  end

  scenario 'Admin can create new category with valid credentials' do
    visit '/categories/new'
    expect(page).to have_content('Create New Category')
    fill_in 'category_name', with: 'Test Category b'
    fill_in 'category_description', with: 'This is a test category'
    click_on 'Submit'

    expect(page).to have_content('Category Created Successfully')
    expect(Category.count).to eq(2)
    expect(Category.first.name).to eq('Test Category a')
    expect(Category.first.description).to eq('This is a test category')
  end

  scenario 'Admin cant create new category with invalid credentials' do
    visit '/categories/new'
    expect(page).to have_content('Create New Category')
    fill_in 'category_name', with: 'Test'
    click_on 'Submit'

    expect(page).to have_content('Name is too short (minimum is 5 characters)')
    expect(Category.count).to eq(1)
  end

  scenario 'Admin can edit a category with valid credentials' do
    visit "/categories/#{category.id}/edit"
    expect(page).to have_content('Edit Category')
    fill_in 'category_name', with: 'Test Category b'
    fill_in 'category_description', with: 'This is a modified test category'
    attach_file('category_image', Rails.root + 'spec/support/assets/Unknown.jpeg')
    click_on 'Submit'

    expect(page).to have_content('Category Updated Successfully')
    expect(Category.count).to eq(1)
    expect(Category.first.name).to eq('Test Category b')
    expect(Category.first.description).to eq('This is a modified test category')
  end

  scenario 'Admin cant edit a category with invalid credentials' do
    visit "/categories/#{category.id}/edit"
    expect(page).to have_content('Edit Category')
    fill_in 'category_name', with: 'Test'
    click_on 'Submit'

    expect(page).to have_content('Name is too short (minimum is 5 characters)')
    expect(Category.count).to eq(1)
    expect(Category.first.name).to eq('Test Category a')
    expect(Category.first.description).to eq('This is a test category')
  end

  scenario "User clicks delete button and confirms deletion" do
    visit '/categories'
    expect(page).to have_content('Manage Categories')
    expect(page).to have_content(category.name)
    find('a.btn-danger[href="' + category_path(category) + '"]').click
    expect(page).to have_content("Category Deleted successfully")
    expect(Category.find_by(id: category.id)).to be_nil
  end

  scenario "deleted category: failure case" do
    allow_any_instance_of(Category).to receive(:destroy).and_return(false)
    visit categories_path
    find('a.btn-danger[href="' + category_path(category) + '"]').click
    expect(current_path).to eq(categories_path)
    expect(Category.find_by(id: category.id)).to_not be_nil
  end

  scenario 'user cannot access non-existent brand record' do
    visit '/categories/99999'

    expect(page).to have_content('Category Record Not Found')
    expect(page).to have_current_path(categories_path)
  end

end
