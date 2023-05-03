# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:product) { create(:product) }
  let(:order) { create(:order) }
  let(:order_item) { build(:order_item, product: product, order: order) }

  describe 'associations' do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:order) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(order_item).to be_valid
    end

    it 'is not valid without a price' do
      order_item.price = nil
      expect(order_item).not_to be_valid
      expect(order_item.errors.messages[:price]).to eq ["is not a number"]
    end

    it 'is not valid with a price less than 1' do
      order_item.price = 0
      expect(order_item).not_to be_valid
      expect(order_item.errors.messages[:price]).to eq ["must be greater than or equal to 1"]
    end

    it 'is not valid without a quantity' do
      order_item.quantity = nil
      expect(order_item).not_to be_valid
      expect(order_item.errors.messages[:quantity]).to eq ["is not a number"]
    end

    it 'is not valid with a quantity less than 1' do
      order_item.quantity = 0
      expect(order_item).not_to be_valid
      expect(order_item.errors.messages[:quantity]).to eq ["must be greater than or equal to 1"]
    end

  end
  
end
