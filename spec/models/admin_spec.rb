require 'rails_helper'

RSpec.describe Admin, type: :model do
  let(:admin) { build(:admin) }

  describe 'associations' do
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(admin).to be_valid
    end

    it 'is not valid without a role' do
      admin.role = nil
      expect(admin).not_to be_valid
      expect(admin.errors.messages[:role]).to eq ["can't be blank", "is not included in the list"]
    end

    it 'is not valid without a username' do
      admin.username = nil
      expect(admin).not_to be_valid
      expect(admin.errors.messages[:username]).to eq ["can't be blank", "is too short (minimum is 5 characters)"]
    end

    it 'is not valid with a username less than 5 characters' do
      admin.username = 'abcd'
      expect(admin).not_to be_valid
      expect(admin.errors.messages[:username]).to eq ['is too short (minimum is 5 characters)']
    end

    it 'is not valid with a username longer than 20 characters' do
      admin.username = 'a' * 21
      expect(admin).not_to be_valid
      expect(admin.errors.messages[:username]).to eq ['is too long (maximum is 20 characters)']
    end

    it 'is not valid without a password' do
      admin.password = nil
      expect(admin).not_to be_valid
      expect(admin.errors.messages[:password]).to eq ["can't be blank"]
    end

    it 'is not valid without a password confirmation' do
      admin.password_confirmation = nil
      expect(admin).not_to be_valid
      expect(admin.errors.messages[:password_confirmation]).to eq ["can't be blank"]
    end

    it 'is not valid with an invalid phone number' do
      admin.phone = '1234567890'
      expect(admin).not_to be_valid
      expect(admin.errors.messages[:phone]).to eq ['number is invalid. Please enter again']
    end

    it 'is valid with a valid phone number' do
      admin.phone = '+923001234567'
      expect(admin).to be_valid
    end
  end

  describe 'column specification' do
    it { should have_db_column(:username).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:encrypted_password).of_type(:string) }
    it { should have_db_column(:role).of_type(:integer) }
    it { should have_db_column(:phone).of_type(:string) }
    it { should have_db_index(:email).unique(true) }
  end
  
end
