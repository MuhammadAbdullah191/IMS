# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Brand, type: :model do
  let(:brand) { build(:brand) }

  describe 'associations' do
    it { is_expected.to have_many(:products).dependent(:destroy) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(brand).to be_valid
    end

    it 'is not valid without a name' do
      brand.name = nil
      expect(brand).not_to be_valid
      expect(brand.errors.messages[:name]).to eq ["can't be blank", "is too short (minimum is 5 characters)"]
    end


    it 'is not valid without a description' do
      brand.description = nil
      expect(brand).not_to be_valid
      expect(brand.errors.messages[:description]).to eq ["can't be blank", "is too short (minimum is 5 characters)"]
    end

    it 'is not valid with a name shorter than 5 characters' do
      brand.name = 'abcd'
      expect(brand).not_to be_valid
      expect(brand.errors.messages[:name]).to eq ['is too short (minimum is 5 characters)']
    end

    it 'is not valid with a name longer than 20 characters' do
      brand.name = 'a' * 21
      expect(brand).not_to be_valid
      expect(brand.errors.messages[:name]).to eq ['is too long (maximum is 20 characters)']
    end

    it 'is not valid with a duplicate name' do
      create(:brand, name: 'Example Brand')
      brand.name = 'Example Brand'
      expect(brand).not_to be_valid
      expect(brand.errors.messages[:name]).to eq ['has already been taken']
    end

  end

  describe 'col-specification' do
    it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:description).of_type(:text).with_options(null: false) }
    it { is_expected.to have_db_index(:name).unique(true) }
  end
  
end
