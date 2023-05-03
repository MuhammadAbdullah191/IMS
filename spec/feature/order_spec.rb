require 'rails_helper'

RSpec.describe 'Order feature', type: :feature do
	let!(:admin) { create(:admin, email: 'test@test.com', password: '111111') }
	let!(:product) { create(:product, name: 'Test Product') }
	let!(:order) { create(:order) }
	let!(:order_item) { create(:order_item, order: order) }

	before do
    login

		visit '/orders/new'
    expect(page).to have_content('Order Cart')
  end


	scenario 'Admin cant place order with empty cart' do
		click_on 'Place Order'
		expect(page).to have_content('Please select atlease one product to create order')
	end

	scenario 'Admin can see all products' do
		expect(page).to have_content(product.name)
	end

	scenario "User clicks delete button and confirms deletion" do
    visit '/orders'
		expect(page).to have_content('Orders')
		expect(page).to have_content(order.id)
		find('a.btn-danger[href="' + order_path(order) + '"]').click
    expect(page).to have_content("Order Deleted successfully")
    expect(Order.find_by(id: order.id)).to be_nil
  end

  scenario "deleted order: failure case" do
    allow_any_instance_of(Order).to receive(:destroy).and_return(false)
    visit orders_path
    find('a.btn-danger[href="' + order_path(order) + '"]').click
    expect(current_path).to eq(orders_path)
    expect(Order.find_by(id: order.id)).to_not be_nil
  end

  scenario 'user cannot access non-existent order record' do
    visit '/orders/99999'

    expect(page).to have_content('Record Not Found')
    expect(page).to have_current_path(orders_path)
  end

  scenario 'Admin can see all order items' do
    visit order_items_path
		expect(page).to have_content(order_item.id)
	end

  scenario 'user cannot access non-existent order-item record' do
    visit order_item_path(99999)

    expect(page).to have_content('Record Not Found')
    expect(page).to have_current_path(order_items_path)
  end

  scenario 'user cannot download non-existent order record' do
    visit '/orders/99999/download'

    expect(page).to have_content('Record Not Found')
    expect(page).to have_current_path(orders_path)
  end

  scenario 'rolls back transaction if an error occurs' do
    order_params = nil
    expect { OrderProcessorService.new(order_params).process_order }.not_to raise_error
  end
  
end