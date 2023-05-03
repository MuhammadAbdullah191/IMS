# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { build(:category) }

  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:products) }
    it { is_expected.to have_one_attached(:image) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(category).to be_valid
    end

    it 'is not valid without a name' do
      category.name = nil
      expect(category).not_to be_valid
      expect(category.errors.messages[:name]).to eq ["can't be blank", "is too short (minimum is 5 characters)"]
    end


    it 'is not valid without a description' do
      category.description = nil
      expect(category).not_to be_valid
      expect(category.errors.messages[:description]).to eq ["can't be blank", "is too short (minimum is 5 characters)"]
    end

    it 'is not valid with a name shorter than 5 characters' do
      category.name = 'abcd'
      expect(category).not_to be_valid
      expect(category.errors.messages[:name]).to eq ['is too short (minimum is 5 characters)']
    end

    it 'is not valid with a name longer than 20 characters' do
      category.name = 'a' * 21
      expect(category).not_to be_valid
      expect(category.errors.messages[:name]).to eq ['is too long (maximum is 20 characters)']
    end

    it 'is not valid with a duplicate name' do
      create(:category, name: 'Example category')
      category.name = 'Example category'
      expect(category).not_to be_valid
      expect(category.errors.messages[:name]).to eq ['has already been taken']
    end

  end

  describe 'col-specification' do
    it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:description).of_type(:text).with_options(null: false) }
    it { is_expected.to have_db_index(:name).unique(true) }
  end
  
end
