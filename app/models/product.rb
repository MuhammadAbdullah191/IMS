class Product < ApplicationRecord
  has_one_attached :image, dependent: :destroy
  belongs_to :brand
  belongs_to :category
  belongs_to :supplier

  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :stock, numericality: { greater_than_or_equal_to: 1 }, on: :create
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true, length: { maximum: 50 }
  validates :price, numericality: { greater_than_or_equal_to: 1 }
end
