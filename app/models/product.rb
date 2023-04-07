class Product < ApplicationRecord
  has_one_attached :image, dependent: :destroy
  belongs_to :brand
  belongs_to :category
  belongs_to :supplier

  validates :name, presence: true, uniqueness: true
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
end
