require 'rails_helper'

RSpec.describe 'JS feature', type: :feature do
	let!(:admin) { create(:admin, email: 'test@test.com', password: '111111') }
	let!(:product) { create(:product, name: 'Test Product') }

	before(:all) do
    Capybara.register_driver :selenium do |app|
			Capybara::Selenium::Driver.new(app, browser: :chrome)
		end
		Capybara.javascript_driver = :selenium
  end

	before do
    login

		visit '/orders/new'
    expect(page).to have_content('Order Cart')
  end


	scenario 'User can add product to the cart', js: true do
    click_button 'Add to cart'
    expect(page).to have_content("Total Price: #{product.price}")
    within('#cart-table') do
      expect(page).to have_content(product.name)
      expect(page).to have_content(product.stock)
      expect(page).to have_content(product.price)
      expect(page).to have_content(product.location_name)
			expect(find('#field-1').value).to eq("1")
    end

  end

	scenario 'User can update product quantity in the cart', js: true do
		click_button 'Add to cart'
	
		within('#cart-table') do
			expect(find('#field-1').value).to eq("1")
	
			fill_in 'field-1', with: '2'
			find('#field-1').send_keys(:tab)
			expect(find('#field-1').value).to eq("2")
		end
		expect(page).to have_content("Total Price: #{product.price * 2}")
	end

	scenario 'User can remove product from cart', js: true do
		click_button 'Add to cart'
    expect(page).to have_content("Total Price: #{product.price}")

		click_button 'Remove From Cart'
		expect(page).to have_content("Total Price: 0")
	end

	scenario 'User can place order after selecting atleast one product', js: true do
		click_button 'Add to cart'
    expect(page).to have_content("Total Price: #{product.price}")

		click_button 'Place Order'
		expect(page).to have_content("Order was successfully created.")
	end

	scenario 'User cant place order with invalid product', js: true do
		click_button 'Add to cart'
    expect(page).to have_content("Total Price: #{product.price}")
		expect { product.destroy }.to change { Product.count }.by(-1)
		click_button 'Place Order'
		expect(page).to have_content("Unable to create order please try again")
	end

	scenario 'User can see order details after creating order', js: true do
		click_button 'Add to cart'
    expect(page).to have_content("Total Price: #{product.price}")
		click_button 'Place Order'
		expect(page).to have_content("Order was successfully created.")
		expect(page).to have_content("Order Details")
		expect(page).to have_content("Order ID: 1")
	end

	scenario 'User can download order details after creating order', js: true do
		click_button 'Add to cart'
    expect(page).to have_content("Total Price: #{product.price}")

		click_button 'Place Order'
		expect(page).to have_content("Order was successfully created.")
		expect(find_link('Download Slip')[:href]).to include('/orders/1/download')
		click_link 'Download Slip'
		sleep 2
	end

	describe 'Analytics' do
		let!(:order_1) { create(:order, created_at: 1.month.ago) }
  	let!(:order_2) { create(:order, created_at: 1.week.ago) }
		let(:order_item) { create(:order_item, order: order, product: product) }
		
		scenario 'User can see analytics of orders placed', js: true do
			visit order_items_path
		end

		scenario 'User searches for orders within a date range', js: true do
			visit orders_path
			expect(page).to have_content(order_1.created_at)
			expect(page).to have_content(order_2.created_at)
			within '#order_search' do
				fill_in 'q_created_at_gteq', with: 2.month.ago.strftime('%d-%m-%Y')
				fill_in 'q_created_at_lteq', with: 2.week.ago.strftime('%d-%m-%Y')
				click_button 'Search'
			end
			expect(page).to have_content(order_1.created_at)
			within '#order_search' do
				fill_in 'q_created_at_gteq', with: 2.month.ago.strftime('%d-%m-%Y')
				fill_in 'q_created_at_lteq', with: 2.month.ago.strftime('%d-%m-%Y')
				click_button 'Search'
			end
			expect(page).to have_content('No Entry Found')
		end

	end


end