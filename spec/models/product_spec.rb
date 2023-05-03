
RSpec.describe Product, type: :model do
  describe 'associations' do
    it { should have_one_attached(:image) }
    it { should have_and_belong_to_many(:categories) }
    it { should have_and_belong_to_many(:suppliers) }
    it { should belong_to(:brand) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(5).is_at_most(20) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(1) }
    it { should validate_presence_of(:categories) }
    it { should validate_presence_of(:suppliers) }
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_least(5).is_at_most(200) }
    it { should validate_numericality_of(:stock).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:stock).is_greater_than_or_equal_to(1).on(:create) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(FactoryBot.build(:product)).to be_valid
    end
  end

  describe 'price' do
    it 'is not valid with non-numeric price' do
      expect(FactoryBot.build(:product, price: 'abc')).not_to be_valid
    end

    it 'is valid with numeric price' do
      expect(FactoryBot.build(:product, price: 10)).to be_valid
    end

    it 'is not valid with negative price' do
      expect(FactoryBot.build(:product, price: -10)).not_to be_valid
    end

    it 'is not valid with zero price' do
      expect(FactoryBot.build(:product, price: 0)).not_to be_valid
    end
  end

  describe 'stock' do
    it 'is not valid with non-numeric stock' do
      expect(FactoryBot.build(:product, stock: 'abc')).not_to be_valid
    end

    it 'is valid with numeric stock' do
      expect(FactoryBot.build(:product, stock: 10)).to be_valid
    end

    it 'is not valid with negative stock' do
      expect(FactoryBot.build(:product, stock: -10)).not_to be_valid
    end

    it 'is not valid with zero stock' do
      expect(FactoryBot.build(:product, stock: 0)).not_to be_valid
    end
    
  end

end
