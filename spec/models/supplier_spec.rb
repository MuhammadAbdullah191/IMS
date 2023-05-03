# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Supplier, type: :model do
  let(:supplier) { build(:supplier) }

  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:products) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(supplier).to be_valid
    end

    it 'is not valid without name' do
      supplier.name = nil
      expect(supplier).not_to be_valid
      expect(supplier.errors.messages[:name]).to eq ["can't be blank"]
    end

    it 'is not valid with name longer than 20 characters' do
      supplier.name = 'a' * 21
      expect(supplier).not_to be_valid
      expect(supplier.errors.messages[:name]).to eq ["is too long (maximum is 20 characters)"]
    end

    it 'is not valid without email' do
      supplier.email = nil
      expect(supplier).not_to be_valid
      expect(supplier.errors.messages[:email]).to eq ["is invalid"]
    end

    it 'is not valid with non-unique email' do
      existing_supplier = create(:supplier)
      supplier.email = existing_supplier.email
      expect(supplier).not_to be_valid
      expect(supplier.errors.messages[:email]).to eq ["has already been taken"]
    end

    it 'is not valid with invalid email format' do
      supplier.email = 'invalid_email'
      expect(supplier).not_to be_valid
      expect(supplier.errors.messages[:email]).to eq ["is invalid"]
    end

    it 'is not valid without phone' do
      supplier.phone = nil
      expect(supplier).not_to be_valid
      expect(supplier.errors.messages[:phone]).to eq ["number is invalid. Please enter again"]
    end

    it 'is not valid with invalid phone format' do
      supplier.phone = 'invalid_phone'
      expect(supplier).not_to be_valid
      expect(supplier.errors.messages[:phone]).to eq ["number is invalid. Please enter again"]
    end

    it 'is not valid without address' do
      supplier.address = nil
      expect(supplier).not_to be_valid
      expect(supplier.errors.messages[:address]).to eq ["can't be blank", "is too short (minimum is 5 characters)"]
    end

    it 'is not valid with address shorter than 5 characters' do
      supplier.address = 'a' * 4
      expect(supplier).not_to be_valid
      expect(supplier.errors.messages[:address]).to eq ["is too short (minimum is 5 characters)"]
    end

  end

end
