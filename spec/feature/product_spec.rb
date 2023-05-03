require 'rails_helper'

  RSpec.describe 'Product feature', type: :feature do
    let!(:admin) { create(:admin, email: 'test@test.com', password: '111111') }
    let!(:product) { create(:product, name: 'Test Product') }
    let!(:brand) { create(:brand, name: 'Test Brand') }
    let!(:category) { create(:category, name: 'Test Category') }
    let!(:supplier) { create(:supplier, name: 'Test Supplier') }

    before do
      login
    end

    scenario 'User can see products on products show page' do
      visit '/products'
      expect(page).to have_content('Manage Products')
      expect(page).to have_content(product.name)
    end

    scenario 'Admin can create new product with valid credintials' do
      visit '/products/new'
      expect(page).to have_content('Create New Product')
      fill_in 'product_name', with: 'Test Product a'
      fill_in 'product_stock', with: 10
      fill_in 'product_description', with: 'This is a test product'
      fill_in 'product_price', with: 100
      fill_in 'product_location_name', with: 'Test Location'
      select 'Test Supplier', from: 'product_supplier_ids'
      select 'Test Brand', from: 'product_brand_id'
      select 'Test Category', from: 'product_category_ids'
      click_on 'Submit'

      expect(page).to have_content('Product Created Successfully')
      expect(Product.count).to eq(2)
    end

    scenario 'Admin cant create new product with invalid credintials' do
      visit '/products/new'
      expect(page).to have_content('Create New Product')
      fill_in 'product_name', with: 'Test'
      click_on 'Submit'

      expect(page).to have_content('Name is too short (minimum is 5 characters)')
    end

    scenario 'Admin can edit product with valid credintials' do
      visit '/products/1/edit'
      expect(page).to have_content('Edit Product')
      fill_in 'product_name', with: 'Test Productsss'
      expect(page).to have_field('product_name', with: 'Test Productsss')
      fill_in 'product_stock', with: 10
      fill_in 'product_description', with: 'This is a test product'
      fill_in 'product_price', with: 100
      fill_in 'product_location_name', with: 'Test Location'
      select 'Test Supplier', from: 'product_supplier_ids'
      select 'Test Brand', from: 'product_brand_id'
      select 'Test Category', from: 'product_category_ids'
      attach_file('product_image', Rails.root + 'spec/support/assets/Unknown.jpeg')

      click_on 'Submit'

      expect(page).to have_content('Product Updated Successfully')
    end

    scenario 'Admin can delete product image' do
      visit '/products/1/edit'
      expect(page).to have_content('Edit Product')
      expect(page).to have_link('Remove') 
      find('a[data-confirm="Are you sure?"]').click
      click_on 'Submit'

      expect(page).to have_content('Product Updated Successfully')
    end

    scenario 'Admin cant edit new product with invalid credintials' do
      visit '/products/1/edit'
      expect(page).to have_content('Edit Product')
      fill_in 'product_name', with: 'Test'
      click_on 'Submit'

      expect(page).to have_content('Name is too short (minimum is 5 characters)')
    end

    scenario "User clicks delete button and confirms deletion" do
      visit '/products'
      expect(page).to have_content('Manage Products')
      expect(page).to have_content(product.name)
      find('a.btn-danger[href="' + product_path(product) + '"]').click
      expect(page).to have_content("Product Deleted successfully")
      expect(Product.find_by(id: product.id)).to be_nil
    end

    scenario "deleted producy: failure case" do
      allow_any_instance_of(Product).to receive(:destroy).and_return(false)
      visit products_path
      find('a.btn-danger[href="' + product_path(product) + '"]').click
      expect(current_path).to eq(products_path)
      expect(Product.find_by(id: product.id)).to_not be_nil
    end

    scenario 'user cannot access non-existent product record' do
      visit '/products/99999'

      expect(page).to have_content('Record Not Found')
      expect(page).to have_current_path(products_path)
    end

end
